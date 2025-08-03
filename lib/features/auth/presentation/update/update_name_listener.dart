import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_custom_dialog.dart';
import 'package:bingo_firebase_example/core/widgets/app_loading_indicator.dart';
import 'package:bingo_firebase_example/features/auth/presentation/providers/update_name_notifier_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateNameListener extends ConsumerWidget {
  const UpdateNameListener({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool hasInitialized = false;

    ref.listen<AsyncValue<User?>>(updateNameNotifierProvider, (previous, next) {
      if (!hasInitialized) {
        hasInitialized = true;
        return;
      }
      next.when(
        loading: () {
          AppLoadingIndicator.show(context);
        },

        data: (data) {
          AppLoadingIndicator.hide(context);
          AppCustomDialog.show(
            context: context,
            okTextButton: AppStrings.ok,
            message: AppStrings.nameChanged,
            okAction: () {},
          );
        },
        error: (error, stackTrace) {
          AppLoadingIndicator.hide(context);
          AppCustomDialog.show(
            context: context,
            okTextButton: AppStrings.ok,
            message: error.toString(),
            okAction: () {},
          );
        },
      );
    });
    return SizedBox();
  }
}
