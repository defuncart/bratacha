import 'package:hive/hive.dart';

import 'flag_data_service.dart';
import 'i_flag_data_service.dart';
import 'i_player_data_service.dart';

class PlayerDataService implements IPlayerDataService {
  /// A box to store objects
  late Box<dynamic> _box;

  /// A name for the box
  static const _boxName = 'player_data';

  /// A database of player's progress on flags
  late IFlagDataService _flagDataService;

  @override
  String get language => _box.get(_Keys.language, defaultValue: _Defaults.language);

  @override
  set language(String value) {
    _box.put(_Keys.language, value);
    _box.put(_Keys.score, _Defaults.score);
    resetAllCountryProgress();
  }

  @override
  bool get isHardDifficulty => _box.get(_Keys.isHardDifficulty, defaultValue: _Defaults.isHardDifficulty);

  @override
  set isHardDifficulty(bool value) => _box.put(_Keys.isHardDifficulty, value);

  @override
  int get score => _box.get(_Keys.score, defaultValue: _Defaults.score);

  @override
  set score(int value) => _box.put(_Keys.score, value);

  @override
  void updateProgress({required String id, required bool answeredCorrectly}) =>
      _flagDataService.updateProgress(id: id, answeredCorrectly: answeredCorrectly);

  @override
  void resetAllCountryProgress() => _flagDataService.reset();

  @override
  Future<void> initialize({IFlagDataService? flagDataService}) async {
    _flagDataService = flagDataService ?? FlagDataService();
    await _flagDataService.initialize();

    _box = await Hive.openBox(_boxName);
  }

  @override
  Future<void> resync({required List<String> ids}) async => await _flagDataService.resync(ids: ids);

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
