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
    yield _CustomLicenseEntry(
      ['flag-icons'],
      [
        const LicenseParagraph(
          '''
The MIT License (MIT)

Copyright (c) 2013 Panayiotis Lipiridis

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
''',
          0,
        ),
      ],
    );
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
      child: kIsWeb ? const _LandscapeApp() : const MyApp(),
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
