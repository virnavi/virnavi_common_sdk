/// Utility class for formatting name strings.
///
/// ```dart
/// NameFormatHelper.format('john doe'); // 'John Doe'
/// NameFormatHelper.format('JANE');     // 'Jane'
/// ```
class NameFormatHelper {
  /// Title-cases [inputString] by capitalising the first letter of every word
  /// and lowercasing the rest.
  ///
  /// Words are separated by spaces. Single-character words are fully
  /// capitalised.
  ///
  /// ```dart
  /// NameFormatHelper.format('hello world'); // 'Hello World'
  /// ```
  static String format(String inputString) {
    List<String> words = inputString.split(' ');

    List<String> formattedWords = words.map((word) {
      if (word.isNotEmpty) {
        if (word.length == 1) {
          return word.toUpperCase();
        }
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
      return word;
    }).toList();

    return formattedWords.join(' ');
  }
}
