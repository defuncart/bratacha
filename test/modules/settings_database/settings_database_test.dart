import 'dart:io';

import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() async {
  // set up clean, temp directory
  final dir = '_temp';
  if (await Directory(dir).exists()) {
    await Directory(dir).delete(recursive: true);
  }

  // initialize Hive and ISettingsDatabase
  Hive.init(dir);
  final ISettingsDatabase settingsDatabase = SettingsDatabase();
  await settingsDatabase.initialize();

  test('Expect default values', () {
    expect(settingsDatabase.hasSeenOnboarding, false);
  });

  test('Update isHardDifficulty, expect new value', () {
    expect(settingsDatabase.hasSeenOnboarding, false);
    settingsDatabase.hasSeenOnboarding = true;
    expect(settingsDatabase.hasSeenOnboarding, true);
  });

  // ensure all temp files are removed
  await Directory(dir).delete(recursive: true);
}
