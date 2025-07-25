import 'package:bingo_firebase_example/core/helper/exteensions.dart';
import 'package:bingo_firebase_example/core/helper/routing/routes.dart';
import 'package:bingo_firebase_example/core/theming/app_assets.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:bingo_firebase_example/features/splash/presentation/providers/splash_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<bool>>(splashNotifierProvider, (previous, next) {
      next.whenData((isLoggedIn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          isLoggedIn
              ? context.pushNamed(Routes.homeRoute)
              : context.pushNamed(Routes.loginRoute);
        });
      });
    });

    return Scaffold(
      backgroundColor: ColorsManager.darckBlue,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            AppAssets.bingoLogo,
            width: AppDimensions.width_250,
            height: AppDimensions.height_250,
          ),
        ),
      ),
    );
  }
}
