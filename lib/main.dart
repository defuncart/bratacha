import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/widgets/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ISettingsDatabase _settingsDatabase = SettingsDatabase();
  await _settingsDatabase.initialize();

  return runApp(
    MyApp(
      settingsDatabase: _settingsDatabase,
    ),
  );
}
