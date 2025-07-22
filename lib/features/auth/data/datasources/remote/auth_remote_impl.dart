import 'package:bingo_firebase_example/core/services/auth_failure.dart';
import 'package:bingo_firebase_example/core/services/auth_service.dart';
import 'package:bingo_firebase_example/features/auth/data/datasources/remote/auth_remote.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteImpl implements AuthRemote {
  final AuthService _authService;

  AuthRemoteImpl(this._authService);

  @override
  Future<Either<AuthFailure, User?>> signIn(String email, String password) {
    return _authService.signIn(email, password);
  }
}
