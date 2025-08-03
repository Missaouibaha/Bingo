import 'dart:async';

import 'package:bingo_firebase_example/features/auth/domain/providers/auth_domain_provider.dart';
import 'package:bingo_firebase_example/features/auth/domain/usecases/change_password_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePasswordNotifier extends AsyncNotifier<Unit?> {
  late final ChangePasswordUseCase _passwordUseCase;
  @override
  FutureOr<Unit?> build() async {
    _passwordUseCase = await ref.read(changePasswordUseCaseProvider.future);
    return null;
  }

  void changePassword(String oldPassword, String newPassword) async {
    state = AsyncValue.loading();
    final result = await _passwordUseCase.call(oldPassword, newPassword);

    result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (success) {
        state = AsyncValue.data(success);
      },
    );
  }
}

final changePasswordNotifierProvider =
    AsyncNotifierProvider<ChangePasswordNotifier, Unit?>(() {
      return ChangePasswordNotifier();
    });
