import 'package:bratacha/modules/player_data/src/utils/utils.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

// ignore_for_file: always_use_package_imports
import '../configs/hive_adapter_type.dart';
import '../models/country_data.dart';
import 'i_player_data_service.dart';

/// A database of the player's device settings
class PlayerDataService implements IPlayerDataService {
  /// A box to store objects
  Box<dynamic> _box;

  /// A name for the box
  static const _boxName = 'player_data';

  /// Asset path for where the default db is located
  static String get defaultAssetPath => 'assets/db/$_boxName.hive';

  /// Returns the selected game language
  @override
  String get language => _box.get(_Keys.language, defaultValue: _Defaults.language);

  /// Sets the selected game language
  @override
  set language(String value) {
    _box.put(_Keys.language, value);
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

  /// A map of [CountryData] by id
  Map<String, CountryData> _countriesData;

  /// Updates the progress for a given id
  @override
  void updateProgress({@required String id, @required bool answeredCorrectly}) {
    final countryData = _countriesData[id];
    countryData.updateProgress(answeredCorrectly: answeredCorrectly);

    _saveCountriesData();
  }

  /// Resets all the player's country progress
  @override
  void resetAllCountryProgress() {
    for (final kvp in _countriesData.entries) {
      kvp.value.reset();
    }

    _saveCountriesData();
  }

  void _saveCountriesData() => _box.put(_Keys.countriesData, _countriesData);

  /// Initializes the database
  @override
  Future<void> initialize() async {
    if (!await Hive.isAdapterRegistered(HiveAdapterType.countryData)) {
      await Hive.registerAdapter(CountryDataAdapter());
    }

    if (!await Hive.boxExists(_boxName)) {
      await reset();
    }

    _box = await Hive.openBox(_boxName);
    _countriesData = _box.get(_Keys.countriesData).cast<String, CountryData>();
  }

  /// Resets the database
  @override
  Future<void> reset() async => await Utils.copyInitialDBToDocuments(filename: _boxName);
}

/// A class of keys used to store values
class _Keys {
  static const language = 'language';
  static const isHardDifficulty = 'isHardDifficulty';
  static const score = 'score';
  static const countriesData = 'countriesData';
}

/// A class of defaults for each key
class _Defaults {
  static const language = 'en';
  static const isHardDifficulty = false;
  static const score = 0;
}
