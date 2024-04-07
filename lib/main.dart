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

  final ISettingsDatabase settingsDatabase = SettingsDatabase();
  await settingsDatabase.initialize();

  final IPlayerDataService playerDataService = PlayerDataService();
  await playerDataService.initialize();
  await playerDataService.resync(ids: CountryService.countries.map((country) => country.id).toList());

  IntlHelper.ensureDelegatesLoaded();

  return runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ISettingsDatabase>(
          create: (_) => settingsDatabase,
        ),
        RepositoryProvider<IPlayerDataService>(
          create: (_) => playerDataService,
        ),
      ],
      child: kIsWeb ? const _WebApp() : const MyApp(),
    ),
  );
}

class _WebApp extends StatelessWidget {
  const _WebApp();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final isMobile = constraints.smallest.shortestSide < 600;
        if (isMobile) {
          return const MyApp();
        }

        final height = constraints.maxHeight;
        final width = height / 2;

        return Container(
          color: Colors.black,
          child: Center(
            child: SizedBox(
              height: height,
              width: width,
              child: const MyApp(),
            ),
          ),
        );
      },
    );
  }
}
