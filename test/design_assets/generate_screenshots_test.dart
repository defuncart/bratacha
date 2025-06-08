import 'package:app_store_screenshots/app_store_screenshots.dart';
import 'package:bratacha/configs/app_themes.dart';
import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/intl/ga_material_localizations.dart';
import 'package:bratacha/intl/generated/localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/game_screen/game_cubit.dart';
import 'package:bratacha/widgets/game_screen/game_screen.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';
import '../test_utils.dart';

void main() {
  late MockLevelManager mockLevelManager;
  late MockLanguageCubit mockLanguageCubit;
  late MockGameCubit mockGameCubit;
  late AppLocalizations localizations;

  setUp(() {
    mockLevelManager = MockLevelManager();
    when(() => mockLevelManager.numberLevels).thenReturn(10);
    when(() => mockLevelManager.progressForLevel(any())).thenReturn(0);
    mockLanguageCubit = MockLanguageCubit();
    whenState(mockLanguageCubit, 'en');
    mockGameCubit = MockGameCubit();
  });

  generateAppStoreScreenshots(
    config: ScreenshotsConfig(
      devices: [DeviceType.androidPhonePortrait],
      locales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        CountryLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GaMaterialLocalizations.delegate,
      ],
      background: ScreenshotBackground.solid(
        color: AppThemes.theme.colorScheme.secondary,
      ),
      theme: AppThemes.theme,
      foregroundOptions: const ScreenshotForegroundOptions.top(
        textStyle: TextStyle(
          fontSize: 96,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        spacer: 32,
      ),
    ),
    screens: [
      ScreenshotScenario(
        onSetUp: (locale) async {
          CountryLocalizations.load(locale);
          localizations = await AppLocalizations.delegate.load(locale);
          whenState(
            mockGameCubit,
            GameStateStartRound(
              progress: 0.5,
              question: CountryLocalizations.getString('us'),
              answers: ['de', 'us', 'gb', 'ie'],
            ),
          );
        },
        onBuildScreen: () => const GameScreenContent(level: 0),
        onGenerateText: (_) => localizations.assetgenScreenshot1Label,
        wrapper: (child) => BlocProvider<GameCubit>.value(
          value: mockGameCubit,
          child: child,
        ),
      ),
      ScreenshotScenario(
        onSetUp: (locale) async {
          CountryLocalizations.load(locale);
          localizations = await AppLocalizations.delegate.load(locale);
          whenState(
            mockGameCubit,
            GameStateStartRound(
              progress: 0.5,
              question: CountryLocalizations.getString('us'),
              answers: ['my', 'us', 'cl', 'lr'],
            ),
          );
        },
        onBuildScreen: () => const GameScreenContent(level: 0),
        onGenerateText: (_) => localizations.assetgenScreenshot2Label,
        wrapper: (child) => BlocProvider<GameCubit>.value(
          value: mockGameCubit,
          child: child,
        ),
      ),
      ScreenshotScenario(
        onSetUp: (locale) async {
          localizations = await AppLocalizations.delegate.load(locale);
          whenState(mockLanguageCubit, locale.languageCode);
        },
        onBuildScreen: () => const HomeScreen(),
        onGenerateText: (_) => localizations.assetgenScreenshot3Label,
        wrapper: (child) => BlocProvider<LanguageCubit>.value(
          value: mockLanguageCubit,
          child: RepositoryProvider<LevelManager>.value(
            value: mockLevelManager,
            child: child,
          ),
        ),
        onPostPumped: (tester) async {
          await tester.tap(find.byIcon(MdiIcons.flagVariantOutline));
        },
      ),
    ],
  );
}
