extension StringFormatting on String {
  /// Parses an ISO-8601 string to local DateTime.
  DateTime get toLocalTime =>
      (DateTime.tryParse(this) ?? DateTime.now()).toLocal();

  /// Capitalizes the first letter.
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// Converts snake_case / SCREAMING_SNAKE to "Title Case".
  String get toTitleCase => split(RegExp(r'[_\s]+'))
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
      .join(' ');
}
