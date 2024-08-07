import 'package:bratacha/configs/app_themes.dart';
import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/intl/ga_material_localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/services/app_info_service/app_info_service.dart';
import 'package:bratacha/services/app_info_service/i_app_info_service.dart';
import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:bratacha/services/url_launcher_service/url_launcher_service.dart';
import 'package:bratacha/widgets/common/panels/hard_mode_panel/hard_mode_cubit.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/game_screen/game_screen.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:bratacha/widgets/onboarding_screen/onboarding_screen.dart';
import 'package:bratacha/widgets/results_screen/results_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // precache svgs
    for (final country in CountryService.countries.map((e) => e.id)) {
      final loader = SvgAssetLoader('assets/flags/$country.svg');
      Cache().putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
    for (final language in AppLocalizations.supportedLocales) {
      final loader = SvgAssetLoader('assets/languages/$language.svg');
      Cache().putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LevelManager>(
          create: (context) => LevelManager(context.read<IPlayerDataService>()),
        ),
        RepositoryProvider<IDialogService>(
          create: (_) => DialogService(),
        ),
        RepositoryProvider<IAppInfoService>(
          create: (_) => AppInfoService()..init(),
        ),
        RepositoryProvider<IUrlLauncherService>(
          create: (_) => UrlLaucherService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LanguageCubit>(
            create: (contextRepositories) => LanguageCubit(contextRepositories.read<IPlayerDataService>()),
          ),
          BlocProvider<HardModeCubit>(
            create: (contextRepositories) => HardModeCubit(contextRepositories.read<IPlayerDataService>()),
          ),
        ],
        child: BlocBuilder<LanguageCubit, String>(
          builder: (_, language) => MaterialApp(
            debugShowCheckedModeBanner: false,
            scrollBehavior: _AppScrollBehavior(),
            builder: (context, widget) => Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => DialogManager(
                  dialogService: context.read<IDialogService>(),
                  child: widget!,
                ),
              ),
            ),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              CountryLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GaMaterialLocalizations.delegate,
              // TODO: Fix GA
              // GaCupertinoLocalizations.delegate,
            ],
            locale: Locale(language),
            supportedLocales: AppLocalizations.supportedLocales,
            theme: AppThemes.theme,
            home: context.read<ISettingsDatabase>().hasSeenOnboarding ? const HomeScreen() : const OnboardingScreen(),
            routes: {
              OnboardingScreen.routeName: (_) => const OnboardingScreen(),
              HomeScreen.routeName: (_) => const HomeScreen(),
              GameScreen.routeName: (_) => const GameScreen(),
              ResultsScreen.routeName: (_) => const ResultsScreen(),
            },
          ),
        ),
      ),
    );
  }
}

class _AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
