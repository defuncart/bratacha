import 'i_flag_data_service.dart';

/// A database of the player's progress
abstract class IPlayerDataService {
  /// Returns the selected game language
  String get language;

  /// Sets the selected game language
  set language(String value);

  /// Returns whether hard mode is enabled
  bool get isHardMode;

  /// Sets whether hard mode is enabled
  set isHardMode(bool value);

  /// Updates the progress for a given id
  void updateProgress({required String id, required bool answeredCorrectly});

  /// Whether player has at least once correctly answered id
  bool hasCorrectlyAnswered({required String id});

  /// Resets all the player's country progress
  void resetAllCountryProgress();

  /// Initializes the database
  Future<void> initialize({IFlagDataService flagDataService});

  /// Resyncs the database for a list of ids
  Future<void> resync({required List<String> ids});

  /// Resets the database
  Future<void> reset();

  /// DEBUG: Prints contents of db to the console
  void debugPrint();
}
