abstract class RegexHelper {
  static String get emailRegex =>
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]\S*$";

  static bool isEmailFormatValid(String email) {
    return RegExp(emailRegex).hasMatch(email);
  }

  static bool isValidText(String name) {
    return name.length >= 3;
  }
}
