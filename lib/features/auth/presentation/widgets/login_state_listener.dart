import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_custom_dialog.dart';
import 'package:bingo_firebase_example/core/widgets/app_loading_indicator.dart';
import 'package:bingo_firebase_example/features/auth/presentation/providers/login_notifier_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginStateListener extends ConsumerWidget {
  const LoginStateListener({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<User?>>(loginNotifierProvider, (previous, next) {
      next.when(
        loading: () {
          AppLoadingIndicator.show(context);
        },
        data: (data) {
          AppLoadingIndicator.hide(context);
          //navigate to home screen
        },
        error: (error, stackTrace) {
          AppLoadingIndicator.hide(context);
          AppCustomDialog.show(
            context: context,
            message: error.toString(),
            okTextButton: AppStrings.confirm,
            okAction: () {},
            isDismissible: true,
          );
        },
      );
    });
    return SizedBox.shrink();
  }
}
