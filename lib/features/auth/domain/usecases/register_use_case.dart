import 'package:bingo_firebase_example/core/services/auth_failure.dart';
import 'package:bingo_firebase_example/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;
  RegisterUseCase(this._authRepository);

  Future<Either<AuthFailure, User?>> call(
    String email,
    String password,
    String name,
  ) {
    return _authRepository.register(email, password, name);
  }
}
