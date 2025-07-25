import 'package:bingo_firebase_example/core/helper/exteensions.dart';
import 'package:bingo_firebase_example/core/helper/routing/routes.dart';
import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_custom_dialog.dart';
import 'package:bingo_firebase_example/core/widgets/app_loading_indicator.dart';
import 'package:bingo_firebase_example/features/auth/presentation/providers/registr_notifier_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterStateListener extends ConsumerWidget {
  const RegisterStateListener({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<User?>>(registerNotifierProvider, (previous, next) {
      if (previous == next) return;

      next.when(
        loading: () {
          AppLoadingIndicator.show(context);
        },
        data: (data) {
          if (data != null) {
            AppLoadingIndicator.hide(context);
            context.pushNamed(Routes.homeRoute);
          }
        },
        error: (error, stackTrace) {
          AppLoadingIndicator.hide(context);
          AppCustomDialog.show(
            context: context,
            okTextButton: AppStrings.ok,
            isDismissible: true,
            message: error.toString(),
            okAction: () {},
          );
        },
      );
    });
    return SizedBox.shrink();
  }
}
