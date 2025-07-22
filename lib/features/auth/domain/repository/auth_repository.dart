import 'package:bingo_firebase_example/core/services/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, User?>> signIn(String email, String password);
}
