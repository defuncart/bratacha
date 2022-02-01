import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/player_data/src/services/i_player_data_service.dart';
import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:bratacha/widgets/home_screen/home_tab/home_tab.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/settings_tab.dart';
import 'package:flutter/material.dart' show Locale, MaterialApp;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  // ensure localizations are setup
  AppLocalizations.load(const Locale('en'));

  group('$HomeScreen', () {
    testWidgets('Ensure tabs can be selected', (tester) async {
      final widget = MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IPlayerDataService>(
            create: (_) => _MockPlayerDataService(),
          ),
          RepositoryProvider<LevelManager>(
            create: (context) => LevelManager(context.read<IPlayerDataService>()),
          ),
          RepositoryProvider<IUrlLaucherService>(
            create: (_) => _MockUrlLauncherService(),
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
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );
      await tester.pumpWidget(widget);

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HomeTab), findsOneWidget);
      expect(find.byType(SettingsTab), findsNothing);

      await tester.tap(find.text(AppLocalizations.settingsTabLabelText));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HomeTab), findsNothing);
      expect(find.byType(SettingsTab), findsOneWidget);

      await tester.tap(find.text(AppLocalizations.homeTabLabelText));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HomeTab), findsOneWidget);
      expect(find.byType(SettingsTab), findsNothing);
    });
  });
}

class _MockPlayerDataService extends Mock implements IPlayerDataService {
  @override
  String get language => 'en';

  @override
  int get score => 0;

  @override
  bool get isHardDifficulty => false;
}

class _MockUrlLauncherService extends Mock implements IUrlLaucherService {}
