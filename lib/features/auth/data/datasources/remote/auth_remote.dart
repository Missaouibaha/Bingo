import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemote {
  Future<Either<AppFirebaseFailure, User?>> signIn(String email, String password);
  Future<Either<AppFirebaseFailure, User?>> register(
    String email,
    String password,
    String name,
  );
}
