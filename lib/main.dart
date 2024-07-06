import 'package:bratacha/configs/app_themes.dart';
import 'package:bratacha/intl/intl_helper.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/widgets/my_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (defaultTargetPlatform == TargetPlatform.android) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(AppThemes.theme.appBarTheme.systemOverlayStyle!);
  }

  LicenseRegistry.addLicense(() async* {
    yield _CustomLicenseEntry([
      'flagpack'
    ], [
      const LicenseParagraph(
        '''
flagpack

Created by https://github.com/jackiboy

Source code: https://github.com/jackiboy/flagpack
''',
        0,
      ),
    ]);
  });

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
      child: const MyApp(),
    ),
  );
}

// ignore: unused_element
class _LandscapeApp extends StatelessWidget {
  const _LandscapeApp();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final isPortrait = constraints.maxWidth < constraints.maxHeight;
        if (isPortrait) {
          return const MyApp();
        }

        final height = constraints.maxHeight;
        final width = height / 2;

        return ColoredBox(
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

class _CustomLicenseEntry extends LicenseEntry {
  _CustomLicenseEntry(
    this.packages,
    this.paragraphs,
  );

  @override
  final Iterable<String> packages;

  @override
  final Iterable<LicenseParagraph> paragraphs;
}
