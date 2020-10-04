/// A database of the user's device settings
abstract class ISettingsDatabase {
  /// Returns the selected language for the ui
  String get language;

  /// Sets the selected language for the ui
  set language(String value);

  /// Initializes the database
  Future<void> initialize();

  /// Resets the database
  Future<void> reset();
}
