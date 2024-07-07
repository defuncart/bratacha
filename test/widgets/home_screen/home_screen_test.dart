import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/player_data/src/services/i_player_data_service.dart';
import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/home_screen/flags_tab/flags_tab.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:bratacha/widgets/home_screen/home_tab/home_tab.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../test_utils.dart';

void main() {
  group('$HomeScreen', () {
    // ensure localizations are setup
    CountryLocalizations.load(const Locale('en'));

    testWidgets('Ensure tabs can be selected', (tester) async {
      final mockPlayerDataService = MockPlayerDataService();
      when(() => mockPlayerDataService.language).thenReturn('en');
      when(() => mockPlayerDataService.isHardDifficulty).thenReturn(false);
      when(() => mockPlayerDataService.hasCorrectlyAnswered(id: any(named: 'id'))).thenReturn(true);

      final widget = MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IPlayerDataService>(
            create: (_) => mockPlayerDataService,
          ),
          RepositoryProvider<LevelManager>(
            create: (context) => LevelManager(context.read<IPlayerDataService>()),
          ),
          RepositoryProvider<IUrlLauncherService>(
            create: (_) => MockUrlLauncherService(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LanguageCubit(context.read<IPlayerDataService>()),
            ),
            BlocProvider(
              create: (context) => HardDifficultyCubit(context.read<IPlayerDataService>()),
            )
          ],
          child: wrapWithMaterialApp(
            const HomeScreen(),
          ),
        ),
      );
      await tester.pumpWidget(widget);

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HomeTab), findsOneWidget);
      expect(find.byType(FlagsTab), findsNothing);
      expect(find.byType(SettingsTab), findsNothing);

      final context = tester.element(find.byType(HomeScreen));

      await tester.tap(find.text(context.l10n.flagsTabLabelText));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HomeTab), findsNothing);
      expect(find.byType(FlagsTab), findsOneWidget);
      expect(find.byType(SettingsTab), findsNothing);

      await tester.tap(find.text(context.l10n.settingsTabLabelText));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HomeTab), findsNothing);
      expect(find.byType(FlagsTab), findsNothing);
      expect(find.byType(SettingsTab), findsOneWidget);
    });
  });
}
