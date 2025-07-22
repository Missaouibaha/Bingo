import 'package:bingo_firebase_example/core/services/auth_failure.dart';
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

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
