import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:flutter_test/flutter_test.dart';

import '../hive_wrapper.dart';

void main() async {
  await hiveWrapper(
    callback: () async {
      final ISettingsDatabase settingsDatabase = SettingsDatabase();
      await settingsDatabase.initialize();

      test('Expect default values', () {
        expect(settingsDatabase.hasSeenOnboarding, false);
      });

      test('Update hasSeenOnboarding, expect new value', () {
        expect(settingsDatabase.hasSeenOnboarding, false);
        settingsDatabase.hasSeenOnboarding = true;
        expect(settingsDatabase.hasSeenOnboarding, true);
      });

      test('Reset, expect default values', () async {
        await settingsDatabase.reset();
        expect(settingsDatabase.hasSeenOnboarding, false);
      });
    },
  );
}
