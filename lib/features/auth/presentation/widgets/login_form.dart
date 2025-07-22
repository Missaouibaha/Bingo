import 'package:bingo_firebase_example/core/helper/exteensions.dart';
import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/utils/app_consts.dart';
import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey formKey;
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding_25),
        child: Column(
          children: [
            AppTextFormField(
              hint: AppStrings.email,
              hasNext: true,
              textController: widget.emailController,
              suffixIcon: Icon(Icons.email),
              validator: (value) {
                return value?.isValidateEmail();
              },
            ),
            verticalSpace(AppDimensions.height_15),
            AppTextFormField(
              hint: AppStrings.password,
              isobscureText: _isPasswordVisible,
              inputType: TextInputType.visiblePassword,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                child: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              ),

              textController: widget.passwordController,
              validator: (value) {
                if (value!.isNullOrEmpty()) {
                  return AppStrings.enterPassword;
                } else if (value.length < AppConsts.passwordMinimumLength) {
                  return AppStrings.passwordConstrainsLength;
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
