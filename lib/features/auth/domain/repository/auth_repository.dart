import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<AppFirebaseFailure, User?>> signIn(
    String email,
    String password,
  );
  Future<Either<AppFirebaseFailure, User?>> register(
    String email,
    String password,
    String name,
  );
  Future<Either<AppFirebaseFailure, User?>> getUser();
  Future<Either<AppFirebaseFailure, User?>> updateName(String name);
  Future<Either<AppFirebaseFailure, Unit>> changePassword(
    String oldPassword,
    String newPassword,
  );
    Future<Either<AppFirebaseFailure, Unit>> logOut();

}
