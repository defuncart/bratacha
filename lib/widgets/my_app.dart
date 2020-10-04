import 'package:bratacha/configs/app_themes.dart';
import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/intl/cy_material_localizations.dart';
import 'package:bratacha/intl/ga_material_localizations.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  final ISettingsDatabase settingsDatabase;

  const MyApp({
    @required this.settingsDatabase,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ISettingsDatabase>(
          create: (_) => settingsDatabase,
        ),
      ],
      child: _MyApp(),
    );
  }
}

class _MyApp extends StatelessWidget {
  const _MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (_) => LanguageCubit(context.repository<ISettingsDatabase>()),
        ),
      ],
      child: __MyApp(),
    );
  }
}

class __MyApp extends StatelessWidget {
  const __MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, String>(
      builder: (_, language) => MaterialApp(
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          const CountryLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          CyMaterialLocalizations.delegate,
          GaMaterialLocalizations.delegate,
        ],
        locale: Locale(language),
        supportedLocales: AppLocalizationsDelegate.supportedLocals,
        theme: AppThemes.theme,
        darkTheme: AppThemes.theme,
        themeMode: ThemeMode.dark,
        home: HomeScreen(),
      ),
    );
  }
}
