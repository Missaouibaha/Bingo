import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:bingo_firebase_example/core/theming/text_styles.dart';
import 'package:bingo_firebase_example/core/utils/app_consts.dart';
import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_rounded_button.dart';
import 'package:bingo_firebase_example/features/auth/presentation/providers/update_name_notifier_provider.dart';
import 'package:bingo_firebase_example/features/auth/presentation/update/update_name_listener.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomSheetChangeName extends StatefulWidget {
  final User? user;
  final VoidCallback refresh;
  const BottomSheetChangeName({
    super.key,
    required this.user,
    required this.refresh,
  });

  @override
  State<BottomSheetChangeName> createState() => _BottomSheetChangeNameState();
}

class _BottomSheetChangeNameState extends State<BottomSheetChangeName> {
  TextEditingController userNameContoller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    userNameContoller.text = widget.user?.displayName ?? '';
    super.initState();
  }

  @override
  void dispose() {
    userNameContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.padding_20,
            vertical: AppDimensions.verticalPadding_20,
          ),
          child: Text(
            AppStrings.changeName,
            style: TextStyles.font23DarkBlueSemiBold,
          ),
        ),

        verticalSpace(AppDimensions.height_50),
        Form(
          key: formKey,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: AppStrings.name,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorsManager.darckBlue,
                  strokeAlign: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.radius_8),
                ),
              ),
            ),
            controller: userNameContoller,

            style: TextStyles.font16BlackMedium,
            validator: (name) {
              if ((name?.length ?? 0) < AppConsts.nameMinimumLength) {
                return AppStrings.nameConstrainsLength;
              }
              return null;
            },
          ),
        ),
        verticalSpace(AppDimensions.height_15),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return AppRoundedButton(
              textButton: AppStrings.save,
              textStyle: TextStyles.font24WhiteMedium,
              buttonWidth: AppDimensions.width_100,
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  ref
                      .read(updateNameNotifierProvider.notifier)
                      .updateName(userNameContoller.text);

                   widget.refresh();
                }
              },
            );
          },
        ),

        UpdateNameListener(),
      ],
    );
  }
}
