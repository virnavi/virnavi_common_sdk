class NameFormatHelper {
  static String format(String inputString) {
    List<String> words =
        inputString.split(' '); // Split the input string by spaces

    List<String> formattedWords = words.map((word) {
      if (word.isNotEmpty) {
        // For single-character words, just capitalize that character
        if (word.length == 1) {
          return word.toUpperCase();
        }
        // Capitalize the first letter and lowercase the rest
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
      return word;
    }).toList();

    return formattedWords
        .join(' '); // Join the formatted words back with a space
  }
}
