import 'dart:async';

import 'package:bingo_firebase_example/core/utils/app_consts.dart';
import 'package:bingo_firebase_example/features/splash/domain/providers/doamin_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() async {
    final useCase = await ref.watch(isLoggedInUseCaseProvider.future);
    final result = await useCase.call();
    Future.delayed(Duration(seconds: AppConsts.splashDelay));
    return result;
  }
}

final splashNotifierProvider = AsyncNotifierProvider<SplashNotifier, bool>(() {
  return SplashNotifier();
});
