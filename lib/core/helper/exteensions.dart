import 'package:bingo_firebase_example/core/utils/app_strings.dart';

extension Regex on String {
  String? isValidateEmail() {
    if (isEmpty) {
      return AppStrings.enterEmail;
    } else if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this)) {
      return AppStrings.enterValidEmail;
    }
    return null;
  }
}

extension NullOrEmpty on String? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
