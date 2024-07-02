import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/results_screen/results_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../test_utils.dart';

void main() {
  // ensure localizations are setup
  CountryLocalizations.load(const Locale('en'));

  group('$ResultsScreen', () {
    // run this test first due to _hasShownPopover
    testWidgets('when next level was just unlocked, expect correct tree', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialAppGeneratedRoute(
          child: const ResultsScreen(),
          arguments: ResultsScreenArguments(
            level: 0,
            correctPercentage: 0.4,
            canPlayNextLevel: true,
            nextLevelUnlocked: true,
            incorrectIds: ['de', 'pl'],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ResultsScreen), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('when next level was not unlocked, expect correct tree', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialAppGeneratedRoute(
          child: const ResultsScreen(),
          arguments: ResultsScreenArguments(
            level: 0,
            correctPercentage: 0.4,
            canPlayNextLevel: true,
            nextLevelUnlocked: false,
            incorrectIds: ['de', 'pl'],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ResultsScreen), findsOneWidget);
      expect(find.byType(SnackBar), findsNothing);
    });

    testWidgets('when perfect round, expect correct tree', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialAppGeneratedRoute(
          child: const ResultsScreen(),
          arguments: ResultsScreenArguments(
            level: 0,
            correctPercentage: 1,
            canPlayNextLevel: true,
            nextLevelUnlocked: true,
            incorrectIds: [],
          ),
        ),
      );

      expect(find.byType(ResultsScreen), findsOneWidget);
      final context = tester.element(find.byType(ResultsScreen));
      expect(find.text(context.l10n.generalLevelLabel(1)), findsOneWidget);
      expect(find.byIcon(MdiIcons.trophyVariant), findsOneWidget);
      expect(find.byIcon(MdiIcons.medalOutline), findsNothing);
      expect(find.text(context.l10n.resultsCongratulations), findsOneWidget);
      expect(find.text(context.l10n.resultsWellDone), findsNothing);
      expect(find.byType(PerfectRoundWidget), findsOneWidget);
      expect(find.byType(MistakesScrollList), findsNothing);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.sync), findsOneWidget);
      expect(find.byIcon(Icons.arrow_right_alt), findsOneWidget);
    });

    testWidgets('when trophy round, expect correct tree', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialAppGeneratedRoute(
          child: const ResultsScreen(),
          arguments: ResultsScreenArguments(
            level: 0,
            correctPercentage: 0.8,
            canPlayNextLevel: true,
            nextLevelUnlocked: true,
            incorrectIds: ['de', 'pl'],
          ),
        ),
      );

      expect(find.byType(ResultsScreen), findsOneWidget);
      final context = tester.element(find.byType(ResultsScreen));
      expect(find.text(context.l10n.generalLevelLabel(1)), findsOneWidget);
      expect(find.byIcon(MdiIcons.trophyVariant), findsOneWidget);
      expect(find.byIcon(MdiIcons.medalOutline), findsNothing);
      expect(find.text(context.l10n.resultsCongratulations), findsOneWidget);
      expect(find.text(context.l10n.resultsWellDone), findsNothing);
      expect(find.byType(PerfectRoundWidget), findsNothing);
      expect(find.byType(MistakesScrollList), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.sync), findsOneWidget);
      expect(find.byIcon(Icons.arrow_right_alt), findsOneWidget);
    });

    testWidgets('when medal round, expect correct tree', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialAppGeneratedRoute(
          child: const ResultsScreen(),
          arguments: ResultsScreenArguments(
            level: 0,
            correctPercentage: 0.4,
            canPlayNextLevel: true,
            nextLevelUnlocked: true,
            incorrectIds: ['de', 'pl'],
          ),
        ),
      );

      expect(find.byType(ResultsScreen), findsOneWidget);
      final context = tester.element(find.byType(ResultsScreen));
      expect(find.text(context.l10n.generalLevelLabel(1)), findsOneWidget);
      expect(find.byIcon(MdiIcons.trophyVariant), findsNothing);
      expect(find.byIcon(MdiIcons.medalOutline), findsOneWidget);
      expect(find.text(context.l10n.resultsCongratulations), findsNothing);
      expect(find.text(context.l10n.resultsWellDone), findsOneWidget);
      expect(find.byType(PerfectRoundWidget), findsNothing);
      expect(find.byType(MistakesScrollList), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.sync), findsOneWidget);
      expect(find.byIcon(Icons.arrow_right_alt), findsOneWidget);
    });

    testWidgets('when next level can be played, expect correct tree', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialAppGeneratedRoute(
          child: const ResultsScreen(),
          arguments: ResultsScreenArguments(
            level: 0,
            correctPercentage: 0.4,
            canPlayNextLevel: true,
            nextLevelUnlocked: true,
            incorrectIds: ['de', 'pl'],
          ),
        ),
      );

      expect(find.byType(ResultsScreen), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.sync), findsOneWidget);
      expect(find.byIcon(Icons.arrow_right_alt), findsOneWidget);
    });

    testWidgets('when next level cannot be played, expect correct tree', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialAppGeneratedRoute(
          child: const ResultsScreen(),
          arguments: ResultsScreenArguments(
            level: 0,
            correctPercentage: 0.4,
            canPlayNextLevel: false,
            nextLevelUnlocked: true,
            incorrectIds: ['de', 'pl'],
          ),
        ),
      );

      expect(find.byType(ResultsScreen), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.sync), findsOneWidget);
      expect(find.byIcon(Icons.arrow_right_alt), findsNothing);
    });
  });
}
