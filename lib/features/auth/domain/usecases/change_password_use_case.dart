import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordUseCase {
  final AuthRepository _authRepository;

  ChangePasswordUseCase(this._authRepository);

  Future<Either<AppFirebaseFailure, Unit>> call(
    String oldPassword,
    String newPassword,
  ) async {
    return await _authRepository.changePassword(oldPassword, newPassword);
  }
}
