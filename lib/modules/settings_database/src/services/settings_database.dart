import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

// ignore: always_use_package_imports
import 'i_settings_database.dart';

/// A database of the player's device settings
class SettingsDatabase implements ISettingsDatabase {
  /// A box to store objects
  Box<dynamic> _box;

  /// A name for the box
  static const _boxName = 'settings';

  /// Returns whether dark mode is enabled
  @override
  bool get isDarkMode => _box.get(_Keys.isDarkMode, defaultValue: _Defaults.isDarkMode);

  /// Sets whether dark mode is enabled
  @override
  set isDarkMode(bool value) => _box.put(_Keys.isDarkMode, value);

  /// Returns the selected language for the ui
  @override
  String get language => _box.get(_Keys.language, defaultValue: _Defaults.language);

  /// Sets the selected language for the ui
  @override
  set language(String value) => _box.put(_Keys.language, value);

  /// Initializes the database
  @override
  Future<void> initialize() async {
    if (!kIsWeb) {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }

    _box ??= await Hive.openBox<dynamic>(_boxName);
  }

  /// Resets the database
  @override
  Future<void> reset() => _box?.deleteAll(_box?.keys);
}

/// A class of keys used to store values
class _Keys {
  static const isDarkMode = 'isDarkMode';
  static const language = 'language';
}

/// A class of defaults for each key
class _Defaults {
  static const isDarkMode = false;
  static const language = 'en';
}
