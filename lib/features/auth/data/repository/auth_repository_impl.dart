import 'package:bingo_firebase_example/core/services/auth_failure.dart';
import 'package:bingo_firebase_example/features/auth/data/datasources/remote/auth_remote.dart';
import 'package:bingo_firebase_example/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemote _authRemote;
  AuthRepositoryImpl(this._authRemote);
  @override
  Future<Either<AuthFailure, User?>> signIn(String email, String password) {
    return _authRemote.signIn(email, password);
  }

  @override
  Future<Either<AuthFailure, User?>> register(
    String email,
    String password,
    String name,
  ) {
    return _authRemote.register(email, password, name);
  }
}
