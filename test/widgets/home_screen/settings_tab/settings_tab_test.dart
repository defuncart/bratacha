import 'package:bloc_test/bloc_test.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/dialog_manager/src/models/responses/confirm_dialog_response.dart';
import 'package:bratacha/modules/dialog_manager/src/services/i_dialog_service.dart';
import 'package:bratacha/modules/player_data/src/services/i_player_data_service.dart';
import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:bratacha/widgets/common/buttons/custom_elevated_button.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_panel.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/feedback_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/settings_popup_menu_button.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../test_utils.dart';

void main() {
  group('$SettingsTab', () {
    late MockHardDifficultyCubit mockHardDifficultyCubit;
    late MockLanguageCubit mockLanguageCubit;
    late Widget widget;

    setUp(() {
      mockHardDifficultyCubit = MockHardDifficultyCubit();
      when(() => mockHardDifficultyCubit.state).thenReturn(false);
      whenListen(mockHardDifficultyCubit, Stream.value(false));
      mockLanguageCubit = MockLanguageCubit();
      when(() => mockLanguageCubit.state).thenReturn('en');
      whenListen(mockLanguageCubit, Stream.value('en'));

      widget = MultiBlocProvider(
        providers: [
          BlocProvider<HardDifficultyCubit>.value(
            value: mockHardDifficultyCubit,
          ),
          BlocProvider<LanguageCubit>.value(
            value: mockLanguageCubit,
          ),
        ],
        child: RepositoryProvider<IUrlLaucherService>(
          create: (_) => MockUrlLauncherService(),
          child: const SettingsTab(),
        ),
      );
    });

    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(widget));

      expect(find.byType(SettingsTab), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(SettingsPopupMenuButton), findsOneWidget);
      final context = tester.element(find.byType(SettingsTab));
      expect(find.text(context.l10n.settingsTabLanguageLabel), findsOneWidget);
      expect(find.byType(LanguagePanel), findsOneWidget);
      expect(find.byType(HardDifficultyPanel), findsOneWidget);
      expect(find.byType(CustomElevatedButton), findsOneWidget);
      expect(find.byType(FeedbackPanel), findsOneWidget);
    });

    testWidgets('Ensure reset progress button is clickable', (tester) async {
      final mockDialogService = MockDialogService();
      final mockPlayerDataService = MockPlayerDataService();
      registerFallbackValue(FakeConfirmDialogRequest());

      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<IDialogService>.value(
              value: mockDialogService,
            ),
            RepositoryProvider<IPlayerDataService>.value(
              value: mockPlayerDataService,
            ),
          ],
          child: wrapWithMaterialApp(widget),
        ),
      );

      final button = find.byType(CustomElevatedButton);

      when(() => mockDialogService.requestConfirmDialog(any()))
          .thenAnswer((_) async => const ConfirmDialogResponse.positive());
      when(() => mockPlayerDataService.reset()).thenAnswer((_) async {});

      await tester.tap(button);

      verify(() => mockPlayerDataService.reset());

      when(() => mockDialogService.requestConfirmDialog(any()))
          .thenAnswer((_) async => const ConfirmDialogResponse.negative());

      await tester.tap(button);

      verifyNever(() => mockPlayerDataService.reset());
    });
  });

  group('LanguageTitle', () {
    test('languageTitle', () {
      expect('en'.languageTitle, 'English');
      expect('be'.languageTitle, 'Беларуская');
      expect('cy'.languageTitle, 'Cymraeg');
      expect('ga'.languageTitle, 'Gaeilge');
      expect(() => 'bla'.languageTitle, throwsArgumentError);
    });
  });
}
