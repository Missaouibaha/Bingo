import 'package:bingo_firebase_example/core/helper/exteensions.dart';
import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/text_styles.dart';
import 'package:bingo_firebase_example/core/utils/app_consts.dart';
import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_rounded_button.dart';
import 'package:bingo_firebase_example/core/widgets/app_text_form_field.dart';
import 'package:bingo_firebase_example/features/auth/presentation/providers/change_password_notifier_provider.dart';
import 'package:bingo_firebase_example/features/auth/presentation/update/update_password_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomSheetChangePassword extends StatefulWidget {
  const BottomSheetChangePassword({super.key});

  @override
  State<BottomSheetChangePassword> createState() =>
      _BottomSheetChangePasswordState();
}

class _BottomSheetChangePasswordState extends State<BottomSheetChangePassword> {
  TextEditingController oldPasswordContoller = TextEditingController();
  TextEditingController newPasswordContoller = TextEditingController();
  TextEditingController confirmNewPasswordContoller = TextEditingController();

  var isOldPassObscureText = false;
  var isNewPassObscureText = false;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    oldPasswordContoller.dispose();
    newPasswordContoller.dispose();
    confirmNewPasswordContoller.dispose();
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
            AppStrings.changePassword,
            style: TextStyles.font23DarkBlueSemiBold,
          ),
        ),

        verticalSpace(AppDimensions.height_50),
        Form(
          key: formKey,
          child: Column(
            children: [
              AppTextFormField(
                hint: AppStrings.oldPassword,
                hasNext: true,
                inputType: TextInputType.visiblePassword,
                textController: oldPasswordContoller,
                inputTextStyle: TextStyles.font16BlackMedium,

                suffixIcon: GestureDetector(
                  onTap:
                      () => setState(() {
                        isOldPassObscureText = !isOldPassObscureText;
                      }),
                  child: Icon(
                    isOldPassObscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
                isobscureText: isOldPassObscureText,
                validator: (password) {
                  if (password.isNullOrEmpty()) {
                    return AppStrings.enterPassword;
                  }
                  return null;
                },
              ),
              verticalSpace(AppDimensions.height_15),
              AppTextFormField(
                hint: AppStrings.newPassword,
                textController: newPasswordContoller,
                inputTextStyle: TextStyles.font16BlackMedium,
                hasNext: true,
                inputType: TextInputType.visiblePassword,
                suffixIcon: GestureDetector(
                  onTap:
                      () => setState(() {
                        isNewPassObscureText = !isNewPassObscureText;
                      }),
                  child: Icon(
                    isNewPassObscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
                isobscureText: isNewPassObscureText,
                validator: (newPassword) {
                  if (newPassword.isNullOrEmpty()) {
                    return AppStrings.enterPassword;
                  } else if ((newPassword?.length ?? 0) <
                      AppConsts.passwordMinimumLength) {
                    return AppStrings.passwordConstrainsLength;
                  }
                  return null;
                },
              ),
              verticalSpace(AppDimensions.height_15),
              AppTextFormField(
                hint: AppStrings.confirmNewPassword,
                textController: confirmNewPasswordContoller,
                inputTextStyle: TextStyles.font16BlackMedium,
                inputType: TextInputType.visiblePassword,
                isobscureText: isNewPassObscureText,
                validator: (confirlNewPassword) {
                  if (confirlNewPassword.isNullOrEmpty()) {
                    return AppStrings.enterPassword;
                  } else if (confirlNewPassword != newPasswordContoller.text) {
                    return AppStrings.confirmNewPassRestriction;
                  }
                  return null;
                },
              ),
            ],
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
                      .watch(changePasswordNotifierProvider.notifier)
                      .changePassword(
                        oldPasswordContoller.text,
                        newPasswordContoller.text,
                      );
                }
              },
            );
          },
        ),

        UpdatePasswordListener(),
      ],
    );
  }
}
