import 'package:bingo_firebase_example/core/services/auth_failure.dart';
import 'package:bingo_firebase_example/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInUseCase {
  final AuthRepository _authRepository;
  SignInUseCase(this._authRepository);

  Future<Either<AuthFailure, User?>> call(String email, String password) async {
    return await _authRepository.signIn(email, password);
  }
}
