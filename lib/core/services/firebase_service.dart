import 'dart:io';

import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/features/home/data/dataSources/models/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class AppFirebaseService {
  AppFirebaseService._privateConstructor();
  static final AppFirebaseService instance =
      AppFirebaseService._privateConstructor();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  bool isUserLoggedIn() => _auth.currentUser != null;

  Future<Either<AppFirebaseFailure, User?>> signIn(
    String email,
    String password,
  ) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Right(result.user);
    } on FirebaseAuthException catch (e) {
      debugPrint('🔥 FirebaseAuthException.code = ${e.code}');
      debugPrint('🔥 FirebaseAuthException.message = ${e.message}');
      return Left(AppFirebaseFailure.fromCode(e.code, e.message));
    } catch (e) {
      return Left(AppFirebaseFailure.unknown(e.toString()));
    }
  }

  Future<Either<AppFirebaseFailure, User?>> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = result.user!.uid;
      try {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'uid': uid,
          'email': email,
          'fullName': name,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        debugPrint('Firestore write error: $e');
      }

      await result.user?.updateDisplayName(name);
      await result.user?.reload();
      final updatedUser = _auth.currentUser;
      return Right(updatedUser);
    } on FirebaseAuthException catch (exception) {
      return Left(
        AppFirebaseFailure.fromCode(exception.code, exception.message),
      );
    } catch (exception) {
      return Left(AppFirebaseFailure.unknown(exception.toString()));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  //---------------------NOTES ---------------

  Future<Either<AppFirebaseFailure, Unit>> addNote(
    String noteDescription,
    String noteTitle,
    File? noteImageFile,
    Uint8List? webImageBytes,
  ) async {
    try {
      // config and activate firebase storage before upload images
      final noteImageUrl = await _uploadNoteImage(noteImageFile, webImageBytes);

      await _firestore.collection('notes').add({
        'title': noteTitle,
        'description': noteDescription,
        'user_id': currentUser?.uid,
        'image_url': noteImageUrl,
        'created_at': FieldValue.serverTimestamp(),
      });

      return Right(unit);
    } catch (exception) {
      return Left(AppFirebaseFailure.handle(exception));
    }
  }

  Future<String?> _uploadNoteImage(File? file, Uint8List? webBytes) async {
    if (file == null && webBytes == null) return null;

    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = _storage.ref().child('note_images/$fileName');
      final metadata = SettableMetadata(contentType: 'image/jpeg');

      if (kIsWeb && webBytes != null) {
        await ref.putData(webBytes, metadata).timeout(Duration(seconds: 10));
      } else if (file != null) {
        await ref.putFile(file, metadata).timeout(Duration(seconds: 10));
      }

      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint("⚠️ Image upload failed: ${e.toString()}");
      return null; // Continue  upload note  without image ..
    }
  }

  Future<Either<AppFirebaseFailure, List<NoteModel>?>> getNotes() async {
    final userId = currentUser?.uid;
    if (userId == null) {
      return Left(AppFirebaseFailure.permissionDenied());
    }

    final querySnapchot =
        await _firestore
            .collection('notes')
            .where('user_id', isEqualTo: userId)
            .orderBy('created_at', descending: true)
            .get();

    final notes =
        querySnapchot.docs.map((doc) {
          return NoteModel.fromMap(doc.data(), doc.id);
        }).toList();

    return Right(notes);
  }

  Stream<Either<AppFirebaseFailure, List<NoteModel>>> watchNotes() async* {
    final userId = currentUser?.uid;

    if (userId == null) {
      yield Left(AppFirebaseFailure.permissionDenied());
      return;
    }
    try {
      yield* _firestore
          .collection('notes')
          .where('user_id', isEqualTo: userId)
          .orderBy('created_at', descending: true)
          .snapshots()
          .map((querySnapshot) {
            final notes =
                querySnapshot.docs.map((doc) {
                  return NoteModel.fromMap(doc.data(), doc.id);
                }).toList();

            return Right<AppFirebaseFailure, List<NoteModel>>(notes);
          })
          .handleError((error) {
            return Left(AppFirebaseFailure.unknown(error.toString()));
          })
          .distinct();
    } catch (exception) {
      yield Left(AppFirebaseFailure.handle(exception));
    }
  }

  Future<Either<AppFirebaseFailure, Unit>> updateNote({
    required String noteId,
    required String title,
    required String description,
  }) async {
    try {
      await _firestore.collection('notes').doc(noteId).update({
        'title': title,
        'description': description,
        'created_at': FieldValue.serverTimestamp(),
      });

      return Right(unit);
    } catch (exception) {
      return Left(AppFirebaseFailure.handle(exception));
    }
  }

  Future<Either<AppFirebaseFailure, Unit>> deleteNoteById(String noteId) async {
    try {
      await _firestore.collection('notes').doc(noteId).delete();
      return Right(unit);
    } catch (exception) {
      return Left(AppFirebaseFailure.handle(exception));
    }
  }

  Future<Either<AppFirebaseFailure, Unit>> deleteAllNotes() async {
    final userId = currentUser?.uid;
    if (userId == null) {
      return Left(AppFirebaseFailure.permissionDenied());
    }

    try {
      final querySnapshot =
          await _firestore
              .collection('notes')
              .where('user_id', isEqualTo: userId)
              .get();

      final batch = _firestore.batch();

      for (final doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();

      return Right(unit);
    } catch (exception) {
      return Left(AppFirebaseFailure.handle(exception));
    }
  }
}
