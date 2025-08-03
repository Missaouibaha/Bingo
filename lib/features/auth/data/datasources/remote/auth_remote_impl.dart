import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/core/services/firebase_service.dart';
import 'package:bingo_firebase_example/features/auth/data/datasources/remote/auth_remote.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteImpl implements AuthRemote {
  final AppFirebaseService _authService;

  AuthRemoteImpl(this._authService);

  @override
  Future<Either<AppFirebaseFailure, User?>> signIn(
    String email,
    String password,
  ) async {
    return await _authService.signIn(email, password);
  }

  @override
  Future<Either<AppFirebaseFailure, User?>> register(
    String email,
    String password,
    String name,
  ) async {
    return await _authService.register(email, password, name);
  }

  @override
  Future<Either<AppFirebaseFailure, User?>> getUser() async {
    return await _authService.getUser();
  }

  @override
  Future<Either<AppFirebaseFailure, User?>> updateName(String name) {
    return _authService.updateName(name);
  }

  @override
  Future<Either<AppFirebaseFailure, Unit>> changePassword(
    String oldPassword,
    String newPassword,
  ) {
    return _authService.updatePassword(oldPassword, newPassword);
  }

  @override
  Future<Either<AppFirebaseFailure, Unit>> logout() {
    return _authService.signOut();
  }
}
