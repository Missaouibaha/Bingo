import 'dart:async';

import 'package:bingo_firebase_example/features/auth/domain/providers/auth_domain_provider.dart';
import 'package:bingo_firebase_example/features/auth/domain/usecases/update_name_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateNameNotifier extends AsyncNotifier<User?> {
  late UpdateNameUseCase _updateNameUseCase;
  @override
  FutureOr<User?> build() async {
    _updateNameUseCase = await ref.read(updateNameUseCaseProvider.future);
    return null;
  }

  void updateName(String newName) async {
    state = AsyncValue.loading();
    final response = await _updateNameUseCase.call(newName);
    response.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (user) {
        state = AsyncValue.data(user);
      },
    );
  }
}

final updateNameNotifierProvider =
    AsyncNotifierProvider<UpdateNameNotifier, User?>(() {
      return UpdateNameNotifier();
    });
