import 'package:meta/meta.dart';

/// A service which interacts with player data databases
abstract class IPlayerDataService {
  /// Returns the selected game language
  String get language;

  /// Sets the selected game language
  set language(String value);

  /// Returns whether hard difficulty is enabled
  bool get isHardDifficulty;

  /// Sets whether hard difficulty is enabled
  set isHardDifficulty(bool value);

  /// Returns the player's score
  int get score;

  /// Sets the player's score
  set score(int value);

  /// Updates the progress for a given id
  void updateProgress({@required String id, @required bool answeredCorrectly});

  /// Resets all the player's country progress
  void resetAllCountryProgress();

  /// Initializes the database
  Future<void> initialize();

  /// Resets the database
  Future<void> reset();
}
