/// A database of the user's device settings
abstract class ISettingsDatabase {
  /// Returns whether dark mode is enabled
  bool get isDarkMode;

  /// Sets whether dark mode is enabled
  set isDarkMode(bool value);

  /// Returns the selected language for the ui
  String get language;

  /// Sets the selected language for the ui
  set language(String value);

  /// Returns whether hard difficulty is enabled
  bool get isHardDifficulty;

  /// Sets whether hard difficulty is enabled
  set isHardDifficulty(bool value);

  /// Initializes the database
  Future<void> initialize();

  /// Resets the database
  Future<void> reset();
}
