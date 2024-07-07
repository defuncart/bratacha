import 'package:bratacha/intl/localizations.dart';
// import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../../../test_utils.dart';

void main() {
  group('$HardDifficultyPanel', () {
    late MockHardDifficultyCubit mockHardDifficultyCubit;

    setUp(() {
      mockHardDifficultyCubit = MockHardDifficultyCubit();
      whenState(mockHardDifficultyCubit, false);
    });

    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(
        BlocProvider<HardDifficultyCubit>.value(
          value: mockHardDifficultyCubit,
          child: wrapWithMaterialApp(
            const Scaffold(
              body: HardDifficultyPanel(),
            ),
          ),
        ),
      );

      expect(find.byType(HardDifficultyPanel), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      final context = tester.element(find.byType(HardDifficultyPanel));
      expect(find.text(context.l10n.hardDifficultyPanelLabel), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('Ensure switch can be toggled', (tester) async {
      await tester.pumpWidget(
        BlocProvider<HardDifficultyCubit>.value(
          value: mockHardDifficultyCubit,
          child: wrapWithMaterialApp(
            const Scaffold(
              body: HardDifficultyPanel(),
            ),
          ),
        ),
      );

      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, isFalse);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      verify(() => mockHardDifficultyCubit.toggle()).called(1);
    });
  });
}
