import 'dart:async';

import 'package:bingo_firebase_example/features/auth/domain/providers/auth_domain_provider.dart';
import 'package:bingo_firebase_example/features/auth/domain/usecases/logout_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogoutNotifier extends AsyncNotifier<Unit?> {
  late LogoutUseCase _logoutUseCase;
  @override
  FutureOr<Unit?> build() async {
    _logoutUseCase = await ref.read(logoutUseCaseProvider.future);
    return null;
  }

  void logout() async {
    state = AsyncValue.loading();

    final response = await _logoutUseCase.call();

    response.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (success) {
        state = AsyncValue.data(success);
      },
    );
  }
}

final logoutNotifierProvider = AsyncNotifierProvider<LogoutNotifier, Unit?>(() {
  return LogoutNotifier();
});
