import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/widgets/common/panels/language_panel/langauge_button.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../../../test_utils.dart';

void main() {
  group('$LanguagePanel', () {
    final numberSupportedLanguages = AppLocalizations.supportedLocales.length;
    late MockLanguageCubit mockLanguageCubit;

    setUp(() {
      mockLanguageCubit = MockLanguageCubit();
      whenState(mockLanguageCubit, 'en');
    });

    testWidgets('ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(
        BlocProvider<LanguageCubit>.value(
          value: mockLanguageCubit,
          child: wrapWithMaterialApp(
            const Scaffold(
              body: LanguagePanel(),
            ),
          ),
        ),
      );

      expect(find.byType(LanguagePanel), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(LanguageButton), findsNWidgets(numberSupportedLanguages));
    });

    group('when language is selected', () {
      testWidgets('and language was already selected, expect nothing happens', (tester) async {
        await tester.pumpWidget(
          BlocProvider<LanguageCubit>.value(
            value: mockLanguageCubit,
            child: wrapWithMaterialApp(
              const Scaffold(
                body: LanguagePanel(),
              ),
            ),
          ),
        );

        expect(find.byType(LanguageButton), findsNWidgets(numberSupportedLanguages));

        await tester.tap(find.byType(LanguageButton).first);
        await tester.pumpAndSettle();

        verifyNever(() => mockLanguageCubit.setLanguage(any()));
      });

      group('and language was not already selected', () {
        late MockDialogService mockDialogService;

        setUp(() {
          mockDialogService = MockDialogService();
          registerFallbackValue(FakeConfirmDialogRequest());
        });

        testWidgets('and user rejected deleting data, expect nothing happens', (tester) async {
          when(() => mockDialogService.requestConfirmDialog(any()))
              .thenAnswer((_) async => const ConfirmDialogResponse.negative());

          await tester.pumpWidget(
            BlocProvider<LanguageCubit>.value(
              value: mockLanguageCubit,
              child: RepositoryProvider<IDialogService>.value(
                value: mockDialogService,
                child: wrapWithMaterialApp(
                  const Scaffold(
                    body: LanguagePanel(),
                  ),
                ),
              ),
            ),
          );

          expect(find.byType(LanguageButton), findsNWidgets(numberSupportedLanguages));

          await tester.tap(find.byType(LanguageButton).last);
          await tester.pumpAndSettle();

          verifyNever(() => mockLanguageCubit.setLanguage(any()));
        });

        testWidgets('and user accepted deleting data, expect language updated', (tester) async {
          when(() => mockDialogService.requestConfirmDialog(any()))
              .thenAnswer((_) async => const ConfirmDialogResponse.positive());

          await tester.pumpWidget(
            BlocProvider<LanguageCubit>.value(
              value: mockLanguageCubit,
              child: RepositoryProvider<IDialogService>.value(
                value: mockDialogService,
                child: wrapWithMaterialApp(
                  const Scaffold(
                    body: LanguagePanel(),
                  ),
                ),
              ),
            ),
          );

          expect(find.byType(LanguageButton), findsNWidgets(numberSupportedLanguages));

          await tester.tap(find.byType(LanguageButton).last);
          await tester.pumpAndSettle();

          verify(() => mockLanguageCubit.setLanguage(any())).called(1);
        });
      });
    });
  });
}
