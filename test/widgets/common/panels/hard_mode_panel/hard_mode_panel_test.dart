import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/panels/hard_mode_panel/hard_mode_cubit.dart';
import 'package:bratacha/widgets/common/panels/hard_mode_panel/hard_mode_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../../../test_utils.dart';

void main() {
  group('$HardModePanel', () {
    late MockHardModeCubit mockHardModeCubit;

    setUp(() {
      mockHardModeCubit = MockHardModeCubit();
      whenState(mockHardModeCubit, false);
    });

    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(
        BlocProvider<HardModeCubit>.value(
          value: mockHardModeCubit,
          child: wrapWithMaterialApp(
            const Scaffold(
              body: HardModePanel(),
            ),
          ),
        ),
      );

      expect(find.byType(HardModePanel), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      final context = tester.element(find.byType(HardModePanel));
      expect(find.text(context.l10n.hardModePanelLabel), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('Ensure switch can be toggled', (tester) async {
      await tester.pumpWidget(
        BlocProvider<HardModeCubit>.value(
          value: mockHardModeCubit,
          child: wrapWithMaterialApp(
            const Scaffold(
              body: HardModePanel(),
            ),
          ),
        ),
      );

      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, isFalse);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      verify(() => mockHardModeCubit.toggle()).called(1);
    });
  });
}
