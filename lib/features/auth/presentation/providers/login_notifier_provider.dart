import 'dart:async';

import 'package:bingo_firebase_example/features/auth/domain/providers/auth_domain_provider.dart';
import 'package:bingo_firebase_example/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends AsyncNotifier<User?> {
  SignInUseCase? _useCase;

  @override
  FutureOr<User?> build() async {
    _useCase = await ref.read(authSignInUseCaseProvider.future);
    return null;
  }

  Future<void> signIn(String email, String password) async {
    state = AsyncLoading();
    final result = await _useCase?.call(email, password);

    result?.fold(
      (exception) {
        state = AsyncValue.error(
          exception?.message ?? exception.toString(),
          StackTrace.current,
        );
      },
      (user) {
        state = AsyncValue.data(user);
      },
    );
  }
}

final loginNotifierProvider = AsyncNotifierProvider<LoginNotifier, User?>(() {
  return LoginNotifier();
});
