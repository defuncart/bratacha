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
    expect(settingsDatabase.language, 'en');
    expect(settingsDatabase.isHardDifficulty, false);
  });

  test('Update language, expect new value', () {
    settingsDatabase.language = 'be';
    expect(settingsDatabase.language, 'be');
  });

  test('Update isHardDifficulty, expect new value', () {
    settingsDatabase.isHardDifficulty = true;
    expect(settingsDatabase.isHardDifficulty, true);
  });

  // ensure all temp files are removed
  await Directory(dir).delete(recursive: true);
}
