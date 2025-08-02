import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:bingo_firebase_example/core/theming/text_styles.dart';
import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_custom_dialog.dart';
import 'package:bingo_firebase_example/features/home/presentation/providers/delete_note_notifier_provider.dart';
import 'package:bingo_firebase_example/features/home/presentation/providers/filtred_note_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchAndDeleteBar extends StatefulWidget {
  const SearchAndDeleteBar({super.key});

  @override
  State<SearchAndDeleteBar> createState() => _HomeSearchAndDeleteBarState();
}

class _HomeSearchAndDeleteBarState extends State<SearchAndDeleteBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.padding_10,
              vertical: AppDimensions.verticalPadding_15,
            ),
            child: Consumer(
              builder: (context, ref, child) {
                return TextField(
                  style: TextStyles.font16BlackMedium,
                  onChanged: (value) {
                    ref.read(searchQueryProvider.notifier).state = value;
                  },
                  decoration: InputDecoration(
                    hintText: AppStrings.note,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppDimensions.radius_16),
                      ),

                      borderSide: BorderSide(color: ColorsManager.grey),
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: AppDimensions.width_30,
                      color: ColorsManager.darkGrey,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        horizontalSpace(AppDimensions.width_5),
        Consumer(
          builder: (context, ref, child) {
            return GestureDetector(
              onTap: () {
                deleteNotes(ref);
              },
              child: Icon(
                Icons.delete_sweep,
                size: AppDimensions.width_35,
                color: ColorsManager.grey,
                shadows: [
                  Shadow(
                    color: ColorsManager.blueAccent,
                    blurRadius: AppDimensions.radius_8,
                    offset: Offset.zero,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void deleteNotes(WidgetRef ref) {
    AppCustomDialog.show(
      context: context,
      isDismissible: true,
      hasTitle: true,
      titleText: AppStrings.deleteNote,
      cancelAction: () {},
      okTextButton: AppStrings.deleteAll,
      okAction: () {
        deleteAllAdvertisment(ref);
      },
      hasCancel: true,
      cancelText: AppStrings.cancel,
      message: AppStrings.deleteAdvertisment,
    );
  }

  void deleteAllAdvertisment(WidgetRef ref) {
    AppCustomDialog.show(
      context: context,
      okTextButton: AppStrings.yes,
      message: AppStrings.deleteAllWarning,
      cancelText: AppStrings.no,
      hasCancel: true,
      cancelAction: () {},
      okAction: () async {
        await ref
            .watch(deleteNoteNotifierProvider.notifier)
            .deleteNote("", true);
      },
    );
  }
}
