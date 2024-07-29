import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/common/flag.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/home_screen/flags_tab/flags_tab.dart';
import 'package:bratacha/widgets/home_screen/flags_tab/search_flags_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../test_utils.dart';

void main() {
  group('$FlagsTab', () {
    // ensure localizations are setup
    CountryLocalizations.load(const Locale('en'));

    late MockPlayerDataService mockPlayerDataService;
    late Widget widget;

    setUp(() {
      mockPlayerDataService = MockPlayerDataService();
      when(() => mockPlayerDataService.language).thenReturn('en');

      widget = MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IPlayerDataService>(
            create: (_) => mockPlayerDataService,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => LanguageCubit(mockPlayerDataService),
            ),
          ],
          child: wrapWithMaterialApp(
            const FlagsTab(),
          ),
        ),
      );
    });

    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(widget));

      expect(find.byType(FlagsTab), findsOneWidget);
      final context = tester.element(find.byType(FlagsTab));
      expect(find.byType(BlocProvider<SearchFlagsCubit>), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text(context.l10n.flagsTabLabelText), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byType(BackButton), findsNothing);
      expect(find.byIcon(Icons.close), findsNothing);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(8));
      expect(find.byType(Flag), findsNWidgets(8));
    });

    testWidgets('Ensure search works correctly', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(widget));

      expect(find.byType(FlagsTab), findsOneWidget);
      final context = tester.element(find.byType(FlagsTab));
      expect(find.byType(BlocProvider<SearchFlagsCubit>), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text(context.l10n.flagsTabLabelText), findsOneWidget);
      expect(find.byType(TextField), findsNothing);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byType(BackButton), findsNothing);
      expect(find.byIcon(Icons.close), findsNothing);

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      expect(find.text(context.l10n.flagsTabLabelText), findsNothing);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsNothing);
      expect(find.byType(BackButton), findsOneWidget);
      expect(find.byIcon(Icons.close), findsNothing);

      await tester.enterText(find.byType(TextField), 'term');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(find.text(context.l10n.flagsTabLabelText), findsNothing);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('term'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsNothing);
      expect(find.byType(BackButton), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });
  });
}
