import 'package:bingo_firebase_example/core/helper/exteensions.dart';
import 'package:bingo_firebase_example/core/helper/routing/routes.dart';
import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_assets.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:bingo_firebase_example/core/theming/text_styles.dart';
import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_rounded_button.dart';
import 'package:bingo_firebase_example/features/auth/presentation/providers/login_notifier_provider.dart';
import 'package:bingo_firebase_example/features/auth/presentation/widgets/login_form.dart';
import 'package:bingo_firebase_example/features/auth/presentation/widgets/login_state_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darckBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.padding_10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(AppDimensions.height_50),
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.welcome,
                  textAlign: TextAlign.start,
                  style: TextStyles.font32WhiteBold,
                ),
              ),
              verticalSpace(AppDimensions.height_50),
              Image.asset(
                AppAssets.bingoLogo,
                height: AppDimensions.height_200,
                width: AppDimensions.width_250,
                color: Colors.white,
              ),
              LoginForm(
                emailController: _emailController,
                passwordController: _passwordController,
                formKey: _formKey,
              ),
              verticalSpace(AppDimensions.height_30),
              Consumer(
                builder: (context, ref, child) {
                  return AppRoundedButton(
                    textButton: AppStrings.confirm,
                    buttonWidth: AppDimensions.width_150,
                    textStyle: TextStyles.font18BlackSemiBold,
                    onPressed: () {
                      _validateFormThenLogin(ref);
                    },
                    backgroundColor: ColorsManager.white,
                  );
                },
              ),
              verticalSpace(AppDimensions.height_30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.hvntAccnt,
                    style: TextStyles.font15LightWhiteRegular,
                  ),
                  horizontalSpace(AppDimensions.width_5),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(Routes.registerRoute);
                    },
                    child: Text(
                      AppStrings.register,
                      style: TextStyles.font15WhiteRegularUnderlined,
                    ),
                  ),
                ],
              ),

              LoginStateListener(),
            ],
          ),
        ),
      ),
    );
  }

  void _validateFormThenLogin(WidgetRef ref) async {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .watch(loginNotifierProvider.notifier)
          .signIn(_emailController.text, _passwordController.text);
    }
  }
}
