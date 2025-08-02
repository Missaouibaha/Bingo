import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_custom_dialog.dart';
import 'package:bingo_firebase_example/core/widgets/app_loading_indicator.dart';
import 'package:bingo_firebase_example/features/home/presentation/providers/delete_note_notifier_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteNoteListener extends ConsumerWidget {
  const DeleteNoteListener({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool hasInitialized = false;

    ref.listen<AsyncValue<Unit>>(deleteNoteNotifierProvider, (previous, next) {
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
          AppCustomDialog(
            okTextButton: AppStrings.ok,
            message: AppStrings.noteDeleted,
            okAction: () {},
          );
        },
        error: (error, stackTrace) {
          AppLoadingIndicator.hide(context);
          AppCustomDialog(
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
