import 'package:hive/hive.dart';

import 'i_settings_database.dart';

/// A database of the player's device settings
class SettingsDatabase implements ISettingsDatabase {
  /// A box to store objects
  Box<dynamic> _box;

  /// A name for the box
  static const _boxName = 'settings';

  /// Returns whether the player has seen onboarding
  @override
  bool get hasSeenOnboarding => _box.get(_Keys.hasSeenOnboarding, defaultValue: _Defaults.hasSeenOnboarding);

  /// Sets whether the player has seen onboarding
  @override
  set hasSeenOnboarding(bool value) => _box.put(_Keys.hasSeenOnboarding, value);

  /// Initializes the database
  @override
  Future<void> initialize() async => _box ??= await Hive.openBox<dynamic>(_boxName);

  /// Resets the database
  @override
  Future<void> reset() => _box?.deleteAll(_box?.keys);
}

/// A class of keys used to store values
class _Keys {
  static const hasSeenOnboarding = 'hasSeenOnboarding';
}

/// A class of defaults for each key
class _Defaults {
  static const hasSeenOnboarding = false;
}
