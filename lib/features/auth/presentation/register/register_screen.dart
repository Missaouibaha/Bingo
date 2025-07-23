import 'package:bingo_firebase_example/core/helper/exteensions.dart';
import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_assets.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:bingo_firebase_example/core/theming/text_styles.dart';
import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_rounded_button.dart';
import 'package:bingo_firebase_example/features/auth/presentation/providers/registr_notifier_provider.dart';
import 'package:bingo_firebase_example/features/auth/presentation/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darckBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.padding_10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.padding_20,
                    vertical: AppDimensions.verticalPadding_20,
                  ),
                  child: Text(
                    AppStrings.register,
                    textAlign: TextAlign.start,
                    style: TextStyles.font32WhiteBold,
                  ),
                ),
                verticalSpace(AppDimensions.height_50),
                Image.asset(
                  AppAssets.bingoLogo,
                  width: AppDimensions.width_250,
                  height: AppDimensions.height_200,
                  color: ColorsManager.white,
                ),
                verticalSpace(AppDimensions.height_30),
                RegisterForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  nameController: _nameController,
                ),
                verticalSpace(AppDimensions.height_20),
                Consumer(
                  builder: (context, ref, child) {
                    return AppRoundedButton(
                      textButton: AppStrings.confirm,
                      buttonWidth: AppDimensions.width_150,
                      textStyle: TextStyles.font18BlackSemiBold,
                      backgroundColor: ColorsManager.white,
                      onPressed: () async {
                        validateFieldsThenRegister(ref);
                      },
                    );
                  },
                ),
                verticalSpace(AppDimensions.height_50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.hvAccnt,
                      style: TextStyles.font15LightWhiteRegular,
                    ),
                    horizontalSpace(AppDimensions.width_5),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Text(
                        AppStrings.signin,
                        style: TextStyles.font15WhiteRegularUnderlined,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> validateFieldsThenRegister(WidgetRef ref) async {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(registerNotifierProvider.notifier)
          .register(
            _emailController.text,
            _nameController.text,
            _passwordController.text,
          );
    }
  }
}
