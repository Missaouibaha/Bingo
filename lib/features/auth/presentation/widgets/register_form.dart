import 'package:bingo_firebase_example/core/helper/exteensions.dart';
import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/utils/app_consts.dart';
import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController nameController;
  final GlobalKey formKey;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameController,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  var isobscureText = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding_25),
        child: Column(
          children: [
            AppTextFormField(
              hint: AppStrings.enterValidName,
              textController: widget.nameController,
              hasNext: true,
              inputType: TextInputType.text,
              suffixIcon: Icon(Icons.person_3_rounded),
              validator: (name) {
                if ((name?.length ?? 0) < AppConsts.nameMinimumLength) {
                  return AppStrings.nameConstrainsLength;
                }
                return null;
              },
            ),
            verticalSpace(AppDimensions.height_20),
            AppTextFormField(
              hint: AppStrings.email,
              textController: widget.emailController,
              hasNext: true,
              inputType: TextInputType.emailAddress,
              suffixIcon: Icon(Icons.email),
              validator: (email) {
                return email?.isValidateEmail();
              },
            ),

            verticalSpace(AppDimensions.height_20),
            AppTextFormField(
              hint: AppStrings.password,
              textController: widget.passwordController,
              hasNext: true,
              inputType: TextInputType.visiblePassword,
              suffixIcon: GestureDetector(
                onTap:
                    () => setState(() {
                      isobscureText = !isobscureText;
                    }),
                child: Icon(
                  isobscureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),

              validator: (password) {
                if (password.isNullOrEmpty()) {
                  return AppStrings.enterPassword;
                } else if ((password?.length ?? 0) <
                    AppConsts.passwordMinimumLength) {
                  return AppStrings.passwordConstrainsLength;
                }
                return null;
              },
              isobscureText: isobscureText,
            ),
            verticalSpace(AppDimensions.height_20),

            AppTextFormField(
              hint: AppStrings.confirmPassword,
              textController: widget.confirmPasswordController,
              inputType: TextInputType.visiblePassword,
              suffixIcon: Icon(
                isobscureText ? Icons.visibility : Icons.visibility_off,
              ),

              validator: (confirmPassword) {
                if (confirmPassword.isNullOrEmpty()) {
                  return AppStrings.enterConfirmPassword;
                } else if (widget.passwordController.text != confirmPassword) {
                  return AppStrings.confirmPassLengthRestriction;
                }
                return null;
              },
              isobscureText: isobscureText,
            ),
          ],
        ),
      ),
    );
  }
}
