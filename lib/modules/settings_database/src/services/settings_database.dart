import 'package:hive/hive.dart';

import 'i_settings_database.dart';

class SettingsDatabase implements ISettingsDatabase {
  /// A box to store objects
  late Box<dynamic> _box;

  /// A name for the box
  static const _boxName = 'settings';

  @override
  bool get hasSeenOnboarding => _box.get(_Keys.hasSeenOnboarding, defaultValue: _Defaults.hasSeenOnboarding);

  @override
  set hasSeenOnboarding(bool value) => _box.put(_Keys.hasSeenOnboarding, value);

  @override
  Future<void> initialize() async => _box = await Hive.openBox<dynamic>(_boxName);

  @override
  Future<void> reset() => _box.deleteAll(_box.keys);
}

/// A class of keys used to store values
class _Keys {
  static const hasSeenOnboarding = 'hasSeenOnboarding';
}

/// A class of defaults for each key
class _Defaults {
  static const hasSeenOnboarding = false;
}
