/// A database of the user's device settings
abstract class ISettingsDatabase {
  /// Returns whether the player has seen onboarding
  bool get hasSeenOnboarding;

  /// Sets whether the player has seen onboarding
  set hasSeenOnboarding(bool value);

  /// Initializes the database
  Future<void> initialize();

  /// Resets the database
  Future<void> reset();
}
