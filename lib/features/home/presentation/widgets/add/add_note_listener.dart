import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_custom_dialog.dart';
import 'package:bingo_firebase_example/core/widgets/app_loading_indicator.dart';
import 'package:bingo_firebase_example/features/home/presentation/providers/add_note_notifier_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNoteListener extends ConsumerWidget {
  const AddNoteListener({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool hasInitialized = false;

    ref.listen<AsyncValue<Unit>>(addNoteNotifierProvider, (previous, next) {
      if (!hasInitialized) {
        hasInitialized = true;
        return;
      }
      next.when(
        loading: () async {
          AppLoadingIndicator.show(context);
        },
        data: (data) {
          AppLoadingIndicator.hide(context);

          AppCustomDialog.show(
            context: context,
            okTextButton: AppStrings.ok,
            message: AppStrings.noteAdded,
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
