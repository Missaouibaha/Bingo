import 'dart:io';

import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
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
    } on FirebaseAuthException catch (exception) {
      return Left(
        AppFirebaseFailure.fromCode(exception.code, exception.message),
      );
    } catch (exception) {
      return Left(AppFirebaseFailure.unknown(exception.toString()));
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
}
