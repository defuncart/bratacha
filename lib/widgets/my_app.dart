import 'package:bratacha/configs/app_themes.dart';
import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/intl/cy_material_localizations.dart';
import 'package:bratacha/intl/ga_material_localizations.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/game_screen/game_screen.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/language_cubit.dart';
import 'package:bratacha/widgets/learn_screen/learn_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LevelManager>(
          create: (_) => LevelManager(_.repository<IPlayerDataService>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LanguageCubit>(
            create: (contextRepositories) => LanguageCubit(contextRepositories.repository<IPlayerDataService>()),
          ),
          BlocProvider<HardDifficultyCubit>(
            create: (contextRepositories) => HardDifficultyCubit(contextRepositories.repository<IPlayerDataService>()),
          ),
        ],
        child: BlocBuilder<LanguageCubit, String>(
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
            home: HomeScreen(),
            routes: {
              LearnScreen.routeName: (_) => LearnScreen(),
              GameScreen.routeName: (_) => GameScreen(),
            },
          ),
        ),
      ),
    );
  }
}
