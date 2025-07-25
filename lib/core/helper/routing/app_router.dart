import 'package:bingo_firebase_example/core/helper/routing/routes.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:bingo_firebase_example/core/theming/text_styles.dart';
import 'package:bingo_firebase_example/features/auth/presentation/login/login_screen.dart';
import 'package:bingo_firebase_example/features/auth/presentation/register/register_screen.dart';
import 'package:bingo_firebase_example/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.splashRoute,
    routes: [
      GoRoute(
        path: Routes.splashRoute,
        name: Routes.splashRoute,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: Routes.loginRoute,
        name: Routes.loginRoute,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: Routes.registerRoute,
        name: Routes.registerRoute,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: Routes.homeRoute,
        name: Routes.homeRoute,
        builder:
            (context, state) => Scaffold(
              backgroundColor: ColorsManager.darckBlue,
              body: SafeArea(
                child: Center(
                  child: Text("Home Screen", style: TextStyles.font32WhiteBold),
                ),
              ),
            ),
      ),
    ],
  );
});
