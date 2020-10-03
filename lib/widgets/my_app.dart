import 'package:bratacha/configs/app_themes.dart';
import 'package:bratacha/country_localizations.dart';
import 'package:bratacha/localizations.dart';
import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/dark_mode_cubit.dart';
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
        BlocProvider<DarkModeCubit>(
          create: (_) => DarkModeCubit(context.repository<ISettingsDatabase>()),
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
    return BlocBuilder<DarkModeCubit, bool>(
      builder: (_, isDarkMode) => MaterialApp(
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          const CountryLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizationsDelegate.supportedLocals,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: HomeScreen(),
      ),
    );
  }
}
