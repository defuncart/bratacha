import 'package:bratacha/configs/app_themes.dart';
import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/intl/cy_material_localizations.dart';
import 'package:bratacha/intl/ga_material_localizations.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/services/app_info_service/app_info_service.dart';
import 'package:bratacha/services/app_info_service/i_app_info_service.dart';
import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:bratacha/services/url_launcher_service/url_launcher_service.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/game_screen/game_screen.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:bratacha/widgets/learn_screen/learn_screen.dart';
import 'package:bratacha/widgets/onboarding_screen/onboarding_screen.dart';
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
        RepositoryProvider<IDialogService>(
          create: (_) => DialogService(),
        ),
        RepositoryProvider<IAppInfoService>(
          create: (_) => AppInfoService(),
        ),
        RepositoryProvider<IUrlLaucherService>(
          create: (_) => UrlLaucherService(),
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
            builder: (context, widget) => Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => DialogManager(
                  dialogService: context.repository<IDialogService>(),
                  child: widget,
                ),
              ),
            ),
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
            home: context.repository<ISettingsDatabase>().hasSeenOnboarding ? HomeScreen() : OnboardingScreen(),
            routes: {
              OnboardingScreen.routeName: (_) => OnboardingScreen(),
              HomeScreen.routeName: (_) => HomeScreen(),
              LearnScreen.routeName: (_) => LearnScreen(),
              GameScreen.routeName: (_) => GameScreen(),
            },
          ),
        ),
      ),
    );
  }
}
