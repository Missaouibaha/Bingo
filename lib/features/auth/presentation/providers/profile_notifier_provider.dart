import 'dart:async';

import 'package:bingo_firebase_example/features/auth/domain/providers/auth_domain_provider.dart';
import 'package:bingo_firebase_example/features/auth/domain/usecases/get_user_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileNotifier extends AsyncNotifier<User?> {
  late GetUserUseCase _getUserUseCase;
  @override
  FutureOr<User?> build() async {
    _getUserUseCase = await ref.read(getUserUseCaseProvider.future);
    return getUser();
  }

  getUser() async {
    final result = await _getUserUseCase.call();

    state = AsyncValue.loading();
    result?.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (user) {
        state = AsyncValue.data(user);
      },
    );
  }
}

final profileNotifiereProvider = AsyncNotifierProvider<ProfileNotifier, User?>(
  () {
    return ProfileNotifier();
  },
);
