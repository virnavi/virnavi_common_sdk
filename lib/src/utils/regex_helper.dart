/// Utility class for common regex-based validations.
///
/// ```dart
/// RegexHelper.isEmailFormatValid('user@example.com'); // true
/// RegexHelper.isValidText('Hi');                      // false (< 3 chars)
/// ```
abstract class RegexHelper {
  /// A regex pattern that matches most valid email addresses.
  static String get emailRegex =>
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]\S*$";

  /// Returns `true` if [email] matches the [emailRegex] pattern.
  static bool isEmailFormatValid(String email) {
    return RegExp(emailRegex).hasMatch(email);
  }

  /// Returns `true` if [name] contains at least 3 characters.
  static bool isValidText(String name) {
    return name.length >= 3;
  }
}
