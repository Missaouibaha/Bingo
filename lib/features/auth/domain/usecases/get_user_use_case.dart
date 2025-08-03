import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUserUseCase {
  final AuthRepository _authRepository;

  GetUserUseCase(this._authRepository);

  Future<Either<AppFirebaseFailure, User?>> call() {
    return _authRepository.getUser();
  }
}
