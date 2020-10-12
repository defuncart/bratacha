import 'package:meta/meta.dart';

// ignore: always_use_package_imports
import 'i_flag_data_service.dart';

/// A database of the player's progress
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
  Future<void> initialize({IFlagDataService flagDataService});

  /// Resyncs the database for a list of ids
  Future<void> resync({@required List<String> ids});

  /// Resets the database
  Future<void> reset();

  /// DEBUG: Prints contents of db to the console
  void debugPrint();
}
