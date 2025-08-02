import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_assets.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: ColorsManager.white,
      elevation: 2,
      title: Container(
        width: AppDimensions.width_100,
        alignment: Alignment.centerLeft,
        child: Image.asset(
          AppAssets.bingoTitle,
          color: ColorsManager.darckBlue,
          fit: BoxFit.contain,
        ),
      ),
      centerTitle: true,
      actionsPadding: EdgeInsets.all(AppDimensions.padding_10),
      automaticallyImplyLeading: false,
      actions: [
        horizontalSpace(AppDimensions.width_10),
        Icon(
          Icons.person_4_outlined,
          color: ColorsManager.darckBlue,
          size: AppDimensions.width_35,
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}