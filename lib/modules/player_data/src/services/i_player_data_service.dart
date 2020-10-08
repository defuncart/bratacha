import 'package:meta/meta.dart';

// ignore: always_use_package_imports
import '../../player_data.dart';

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

  /// Returns [CountryData] for a given id
  CountryData countryData({@required String id});

  /// Initializes the database
  Future<void> initialize();

  /// Resets the database
  Future<void> reset();
}
