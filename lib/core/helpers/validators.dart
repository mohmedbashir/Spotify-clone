import 'package:spotify/core/extensions/valid_email_password.dart';

class AppValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    if (!value.isValidEmail()) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  static String? passwordValidator(String? value, bool? isSignInForm) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (isSignInForm == false) {
      if (value.length < 6) {
        return 'Password must be at least 6 characters long.';
      }
      if (!RegExp(r'[A-Z]').hasMatch(value)) {
        return 'Must contain at least one uppercase letter.';
      }
      if (!RegExp(r'[a-z]').hasMatch(value)) {
        return 'Must contain at least one lowercase letter.';
      }
      if (!RegExp(r'\d').hasMatch(value)) {
        return 'Password must contain at least one digit.';
      }
      if (!RegExp(r'''[!@#\$%\^&\*\(\)_\-\+=\[\]\{\};:\'",<>\.?\\/\|`~]''')
          .hasMatch(value)) {
        return 'Must contain at least one special character.';
      }
    }
    return null;
  }

  static String? fullNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required.';
    }
    if (!value.isValidFullName()) {
      return 'Enter a valid full name (two words)';
    }
    return null;
  }
}
