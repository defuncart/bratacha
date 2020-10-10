import 'package:bratacha/intl/intl_helper.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/widgets/my_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final IPlayerDataService _playerDataService = PlayerDataService();
  await _playerDataService.initialize();
  await _playerDataService.resync(ids: CountryService.countries.map((country) => country.id).toList());

  await IntlHelper.ensureDelegatesLoaded();

  return runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ISettingsDatabase>(
          create: (_) => _settingsDatabase,
        ),
        RepositoryProvider<IPlayerDataService>(
          create: (_) => _playerDataService,
        ),
      ],
      child: MyApp(),
    ),
  );
}
