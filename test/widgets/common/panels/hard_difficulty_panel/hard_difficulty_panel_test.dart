import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  // ensure localizations are setup
  AppLocalizations.load(const Locale('en'));

  group('$HardDifficultyPanel', () {
    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(
        BlocProvider<HardDifficultyCubit>(
          create: (_) => HardDifficultyCubit(_MockPlayerDataService()),
          child: const MaterialApp(
            home: Scaffold(
              body: HardDifficultyPanel(),
            ),
          ),
        ),
      );

      expect(find.byType(HardDifficultyPanel), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text(AppLocalizations.hardDifficultyPanelLabel), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('Ensure switch is toggleable', (tester) async {
      final playerDataService = _MockPlayerDataService();
      final cubit = HardDifficultyCubit(playerDataService);
      await tester.pumpWidget(
        BlocProvider<HardDifficultyCubit>(
          create: (_) => cubit,
          lazy: false,
          child: const MaterialApp(
            home: Scaffold(
              body: HardDifficultyPanel(),
            ),
          ),
        ),
      );

      var switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, isFalse);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, isTrue);
    });
  });
}

class _MockPlayerDataService extends Mock implements IPlayerDataService {
  bool _isHardDifficulty;

  _MockPlayerDataService({bool isHardDifficulty = false}) : _isHardDifficulty = isHardDifficulty;

  @override
  bool get isHardDifficulty => _isHardDifficulty;

  @override
  set isHardDifficulty(bool value) => _isHardDifficulty = value;
}
