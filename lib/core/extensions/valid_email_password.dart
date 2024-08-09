extension StringExtensions on String {
  bool isValidEmail() {
    final RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}$");
    return emailRegExp.hasMatch(this);
  }

  bool isValidPassword(int minLength) {
    if (this.length < minLength) return false;

    final RegExp uppercaseRegExp = RegExp(r'[A-Z]');
    final RegExp lowercaseRegExp = RegExp(r'[a-z]');
    final RegExp digitRegExp = RegExp(r'\d');
    final RegExp specialCharRegExp =
        RegExp(r'''[!@#\$%\^&\*\(\)_\-\+=\[\]\{\};:\'",<>\.?\\/\|`~]''');

    return uppercaseRegExp.hasMatch(this) &&
        lowercaseRegExp.hasMatch(this) &&
        digitRegExp.hasMatch(this) &&
        specialCharRegExp.hasMatch(this);
  }

  bool isValidFullName() {
    final RegExp nameRegExp = RegExp(r"^[a-zA-Z]+(?: [a-zA-Z]+)+$");
    return nameRegExp.hasMatch(this);
  }
}
