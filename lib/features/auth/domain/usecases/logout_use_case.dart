import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  Future<Either<AppFirebaseFailure, Unit>> call() {
    return _authRepository.logOut();
  }
}
