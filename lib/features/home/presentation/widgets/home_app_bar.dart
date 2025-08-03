import 'package:bingo_firebase_example/core/helper/routing/routes.dart';
import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_assets.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:bingo_firebase_example/core/utils/app_consts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      actionsPadding: EdgeInsets.symmetric(
        vertical: AppDimensions.verticalPadding_5,
      ),
      automaticallyImplyLeading: false,
      actions: [
        horizontalSpace(AppDimensions.width_10),
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.profileRoute);
          },
          child: Container(
            padding: EdgeInsets.all(3),

            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: AppDimensions.radius_35,
              backgroundImage: NetworkImage(AppConsts.fakePhotoProfile),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
