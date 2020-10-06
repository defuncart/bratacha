import 'package:bratacha/intl/intl_helper.dart';
import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/widgets/my_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  final ISettingsDatabase _settingsDatabase = SettingsDatabase();
  await _settingsDatabase.initialize();

  await IntlHelper.ensureDelegatesLoaded();

  return runApp(
    MyApp(
      settingsDatabase: _settingsDatabase,
    ),
  );
}
