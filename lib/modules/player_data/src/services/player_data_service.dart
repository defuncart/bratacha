import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

// ignore_for_file: always_use_package_imports
import 'flag_data_service.dart';
import 'i_flag_data_service.dart';
import 'i_player_data_service.dart';

/// A database of the player's progress
class PlayerDataService implements IPlayerDataService {
  /// A box to store objects
  Box<dynamic> _box;

  /// A name for the box
  static const _boxName = 'player_data';

  /// A database of player's progress on flags
  IFlagDataService _flagDataService;

  /// Returns the selected game language
  @override
  String get language => _box.get(_Keys.language, defaultValue: _Defaults.language);

  /// Sets the selected game language
  @override
  set language(String value) {
    _box.put(_Keys.language, value);
    _box.put(_Keys.score, _Defaults.score);
    resetAllCountryProgress();
  }

  /// Returns whether hard difficulty is enabled
  @override
  bool get isHardDifficulty => _box.get(_Keys.isHardDifficulty, defaultValue: _Defaults.isHardDifficulty);

  /// Sets whether hard difficulty is enabled
  @override
  set isHardDifficulty(bool value) => _box.put(_Keys.isHardDifficulty, value);

  /// Returns the player's score
  @override
  int get score => _box.get(_Keys.score, defaultValue: _Defaults.score);

  /// Sets the player's score
  @override
  set score(int value) => _box.put(_Keys.score, value);

  /// Updates the progress for a given id
  @override
  void updateProgress({@required String id, @required bool answeredCorrectly}) =>
      _flagDataService.updateProgress(id: id, answeredCorrectly: answeredCorrectly);

  /// Resets all the player's country progress
  @override
  void resetAllCountryProgress() => _flagDataService.reset();

  /// Initializes the database
  @override
  Future<void> initialize({IFlagDataService flagDataService}) async {
    _flagDataService = flagDataService ?? FlagDataService();
    await _flagDataService.initialize();

    _box = await Hive.openBox(_boxName);
  }

  /// Resyncs the database for a list of ids
  @override
  Future<void> resync({@required List<String> ids}) async => await _flagDataService.resync(ids: ids);

  /// Resets the database
  @override
  Future<void> reset() async => await _box.deleteAll(_box.keys);

  // coverage:ignore-start
  /// DEBUG: Prints contents of db to the console
  @override
  void debugPrint() {
    print('---- PlayerDataService ----');
    for (final kvp in _box.toMap().entries) {
      print('${kvp.key} : ${kvp.value}');
    }
    _flagDataService.debugPrint();
    print('---------------------------');
  }
  // coverage:ignore-end
}

/// A class of keys used to store values
class _Keys {
  static const language = 'language';
  static const isHardDifficulty = 'isHardDifficulty';
  static const score = 'score';
}

/// A class of defaults for each key
class _Defaults {
  static const language = 'en';
  static const isHardDifficulty = false;
  static const score = 0;
}
