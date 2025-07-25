import 'package:bingo_firebase_example/core/helper/exteensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: ColorsManager.white),
    );
  }

  static void show(BuildContext context) {
    showDialog(context: context, builder: (_) => const AppLoadingIndicator());
  }

  static void hide(BuildContext context) {
    context.pop();
  }
}
