import 'package:hive/hive.dart';

// ignore: always_use_package_imports
import 'i_settings_database.dart';

/// A database of the player's device settings
class SettingsDatabase implements ISettingsDatabase {
  /// A box to store objects
  Box<dynamic> _box;

  /// A name for the box
  static const _boxName = 'settings';

  /// Returns the selected language for the ui
  @override
  String get language => _box.get(_Keys.language, defaultValue: _Defaults.language);

  /// Sets the selected language for the ui
  @override
  set language(String value) => _box.put(_Keys.language, value);

  /// Returns whether hard difficulty is enabled
  @override
  bool get isHardDifficulty => _box.get(_Keys.isHardDifficulty, defaultValue: _Defaults.isHardDifficulty);

  /// Sets whether hard difficulty is enabled
  @override
  set isHardDifficulty(bool value) => _box.put(_Keys.isHardDifficulty, value);

  /// Initializes the database
  @override
  Future<void> initialize() async {
    _box ??= await Hive.openBox<dynamic>(_boxName);
  }

  /// Resets the database
  @override
  Future<void> reset() => _box?.deleteAll(_box?.keys);
}

/// A class of keys used to store values
class _Keys {
  static const language = 'language';
  static const isHardDifficulty = 'isHardDifficulty';
}

/// A class of defaults for each key
class _Defaults {
  static const language = 'en';
  static const isHardDifficulty = false;
}
