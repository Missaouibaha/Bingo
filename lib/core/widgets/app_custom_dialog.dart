import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:bingo_firebase_example/core/theming/text_styles.dart';
import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppCustomDialog extends StatefulWidget {
  final bool hasTitle;
  final String? titleText;
  final String okTextButton;
  final bool hasCancel;
  final String? cancelText;
  final String message;
  final bool hasIcon;
  final String? iconPath;
  final VoidCallback okAction;
  final VoidCallback? cancelAction;
  final bool? isDismissible;

  const AppCustomDialog({
    super.key,
    this.hasTitle = false,
    this.titleText,
    required this.okTextButton,
    this.hasCancel = false,
    this.cancelText,
    required this.message,
    this.hasIcon = false,
    this.iconPath,
    required this.okAction,
    this.cancelAction,
    this.isDismissible = false,
  });

  static Future<void> show({
    required BuildContext context,
    hasTitle = false,
    titleText,
    required okTextButton,
    hasCancel = false,
    cancelText,
    required message,
    hasIcon = false,
    iconPath,
    required okAction,
    cancelAction,
    isDismissible = false,
  }) async {
    await showDialog(
      context: context,

      barrierDismissible: isDismissible,
      builder: (_) {
        return AppCustomDialog(
          hasTitle: hasTitle,
          titleText: titleText,
          hasCancel: hasCancel,
          cancelText: cancelText,
          cancelAction: cancelAction,
          hasIcon: hasIcon,
          iconPath: iconPath,
          okTextButton: okTextButton,
          okAction: okAction,
          message: message,
          isDismissible: isDismissible,
        );
      },
    );
  }

  @override
  State<AppCustomDialog> createState() => _AppCustomDialogState();
}

class _AppCustomDialogState extends State<AppCustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsManager.white,
      title:
          (widget.hasTitle)
              ? Center(
                child: Text(
                  widget.titleText!,
                  style: TextStyles.font18BlackSemiBold,
                ),
              )
              : null,

      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.hasIcon)
            Image.asset(
              widget.iconPath!,
              width: AppDimensions.width_70,
              height: AppDimensions.height_70,
              color: ColorsManager.darckBlue,
            ),
          verticalSpace(AppDimensions.height_30),
          Text(widget.message, style: TextStyles.font14DarckBlueMedium),
        ],
      ),
      actions: [
        if (widget.hasCancel)
          TextButton(
            onPressed: () {
              widget.cancelAction!();
              context.pop();
            },
            child: Text(
              widget.cancelText ?? AppStrings.cancel,
              style: TextStyles.font14DarckBlueMedium,
            ),
          ),
        ElevatedButton(
          onPressed: () {
            widget.okAction();
            context.pop();
          },
          child: Text(
            widget.okTextButton ?? AppStrings.ok,
            style: TextStyles.font14DarckBlueMedium,
          ),
        ),
      ],
    );
  }
}
