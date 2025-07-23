import 'dart:async';

import 'package:bingo_firebase_example/features/auth/domain/providers/auth_domain_provider.dart';
import 'package:bingo_firebase_example/features/auth/domain/usecases/register_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrNotifier extends AsyncNotifier<User?> {
  late RegisterUseCase _registerUseCase;
  @override
  FutureOr<User?> build() async {
    _registerUseCase = await ref.read(authRegisterUseCaseProvider.future);
    return null;
  }

  Future<void> register(String email, String name, String password) async {
    state = const AsyncLoading();
    final result = await _registerUseCase.call(email, password, name);

    result.fold(
      (failure) {
        state = AsyncValue.error(
          failure.message ?? failure.toString(),
          StackTrace.current,
        );
      },
      (user) {
        state = AsyncValue.data(user);
      },
    );
  }
}

final registerNotifierProvider = AsyncNotifierProvider<RegistrNotifier, User?>(
  () {
    return RegistrNotifier();
  },
);
