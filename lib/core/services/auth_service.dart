import 'package:bingo_firebase_example/core/services/auth_failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();
  final _auth = FirebaseAuth.instance;

  Future<Either<AuthFailure, User?>> signIn(
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
      return Left(AuthFailure.fromCode(e.code, e.message));
    } catch (e) {
      return Left(AuthFailure.unknown(e.toString()));
    }
  }

  Future<Either<AuthFailure, User?>> register(
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
      return Left(AuthFailure.fromCode(exception.code, exception.message));
    } catch (exception) {
      return Left(AuthFailure.unknown(exception.toString()));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
