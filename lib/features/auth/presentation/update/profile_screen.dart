import 'package:bingo_firebase_example/core/helper/exteensions.dart';
import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:bingo_firebase_example/core/theming/text_styles.dart';
import 'package:bingo_firebase_example/core/utils/app_consts.dart';
import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_custom_dialog.dart';
import 'package:bingo_firebase_example/features/auth/presentation/providers/logout_notifier_provider.dart';
import 'package:bingo_firebase_example/features/auth/presentation/providers/profile_notifier_provider.dart';
import 'package:bingo_firebase_example/features/auth/presentation/update/bottom_sheet_change_name.dart';
import 'package:bingo_firebase_example/features/auth/presentation/update/bottom_sheet_change_password.dart';
import 'package:bingo_firebase_example/features/auth/presentation/update/logout_listener.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? user;
    final userAsync = ref.watch(profileNotifiereProvider);
    userAsync.whenData((value) => user = value);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.padding_10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton.outlined(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: ColorsManager.darckBlue,
                  size: AppDimensions.width_25,
                ),
              ),
              verticalSpace(AppDimensions.height_50),
              Center(
                child: CircleAvatar(
                  radius: AppDimensions.radius_100,
                  backgroundImage: NetworkImage(AppConsts.fakePhotoProfile),
                ),
              ),

              verticalSpace(AppDimensions.height_30),
              ..._buildTitle(
                "${AppStrings.changeName}      ${user?.displayName ?? ''}",
                Icons.person_3_outlined,
                Icons.arrow_forward_ios,

                () => updateName(context, user, ref),
              ),
              ..._buildTitle(
                AppStrings.changePassword,
                Icons.lock_outline_rounded,
                Icons.arrow_forward_ios,
                () => updatePassword(context),
              ),

              ListTile(
                title: Text(
                  AppStrings.logOut,
                  style: TextStyles.font16BlackMedium,
                ),
                leading: Icon(Icons.logout_outlined, color: ColorsManager.red),
                onTap: () {
                  AppCustomDialog.show(
                    context: context,
                    okTextButton: AppStrings.logOut,
                    message: AppStrings.logOutWarning,
                    okAction: () {
                      ref.watch(logoutNotifierProvider.notifier).logout();
                    },
                    hasCancel: true,
                    cancelText: AppStrings.cancel,
                    cancelAction: () {},
                  );
                },
              ),
              LogoutListener(),
            ],
          ),
        ),
      ),
    );
  }

  void updateName(BuildContext context, User? user, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.padding_25,
            vertical: AppDimensions.verticalPadding_25,
          ),
          child: BottomSheetChangeName(
            user: user,
            refresh: () {
              ref.invalidate(profileNotifiereProvider);
            },
          ),
        );
      },
    );
  }

  void updatePassword(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            AppDimensions.padding_25,
            AppDimensions.verticalPadding_25,
            AppDimensions.padding_25,
            MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BottomSheetChangePassword(),
        );
      },
    );
  }

  List<Widget> _buildTitle(
    String tileText,
    IconData leadingIconData,
    IconData trailingIconData,
    VoidCallback onTap,
  ) {
    return [
      ListTile(
        title: Text(tileText ?? '', style: TextStyles.font16BlackMedium),
        leading: Icon(leadingIconData, color: ColorsManager.darckBlue),
        trailing: Icon(trailingIconData, color: ColorsManager.darckBlue),
        onTap: () => onTap(),
      ),
      Divider(
        color: ColorsManager.grey,
        indent: AppDimensions.width_5,
        endIndent: AppDimensions.width_5,
        height: AppDimensions.height_2,
      ),
      verticalSpace(AppDimensions.height_15),
    ];
  }
}
