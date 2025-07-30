import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:bingo_firebase_example/features/home/presentation/widgets/bottom_sheet_add_note.dart';
import 'package:flutter/material.dart';

class FloatBtnAddNote extends StatelessWidget {
  const FloatBtnAddNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          0,
          0,
          AppDimensions.padding_10,
          AppDimensions.verticalPadding_10,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: ColorsManager.white,
            elevation: 6,
            padding: EdgeInsets.all(AppDimensions.padding_5),
          ),
          onPressed: () {
            showBottomSheetAddNote(context);
          },
          child: Icon(
            Icons.add_circle_outline_rounded,
            color: ColorsManager.darckBlue,
            size: AppDimensions.width_50,
          ),
        ),
      ),
    );
  }

  void showBottomSheetAddNote(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radius_16),
          topRight: Radius.circular(AppDimensions.radius_16),
        ),
      ),
      builder: (context) {
        return BottomSheetAddNote();
      },
    );
  }
}
