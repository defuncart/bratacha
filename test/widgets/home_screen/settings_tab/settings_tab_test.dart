import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/player_data/src/services/i_player_data_service.dart';
import 'package:bratacha/services/app_info_service/i_app_info_service.dart';
import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:bratacha/widgets/common/buttons/custom_elevated_button.dart';
import 'package:bratacha/widgets/common/panels/hard_mode_panel/hard_mode_cubit.dart';
import 'package:bratacha/widgets/common/panels/hard_mode_panel/hard_mode_panel.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/feedback_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../test_utils.dart';

void main() {
  group('$SettingsTab', () {
    late MockHardModeCubit mockHardModeCubit;
    late MockLanguageCubit mockLanguageCubit;
    late Widget widget;

    setUp(() {
      mockHardModeCubit = MockHardModeCubit();
      whenState(mockHardModeCubit, false);
      mockLanguageCubit = MockLanguageCubit();
      whenState(mockLanguageCubit, 'en');

      widget = MultiBlocProvider(
        providers: [
          BlocProvider<HardModeCubit>.value(
            value: mockHardModeCubit,
          ),
          BlocProvider<LanguageCubit>.value(
            value: mockLanguageCubit,
          ),
        ],
        child: RepositoryProvider<IUrlLauncherService>(
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
      expect(find.byType(IconButton), findsOneWidget);
      final context = tester.element(find.byType(SettingsTab));
      expect(find.text(context.l10n.settingsTabLanguageLabel), findsOneWidget);
      expect(find.byType(LanguagePanel), findsOneWidget);
      expect(find.byType(HardModePanel), findsOneWidget);
      expect(find.byType(CustomElevatedButton), findsOneWidget);
      expect(find.byType(FeedbackPanel), findsOneWidget);
    });

    testWidgets('Ensure info button is clickable', (tester) async {
      final mockDialogService = MockDialogService();
      final mockAppInfoService = MockAppInfoService();
      registerFallbackValue(FakeCustomDialogRequest());

      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<IDialogService>.value(
              value: mockDialogService,
            ),
            RepositoryProvider<IAppInfoService>.value(
              value: mockAppInfoService,
            ),
          ],
          child: wrapWithMaterialApp(widget),
        ),
      );

      final button = find.byType(IconButton);

      when(() => mockDialogService.requestCustomDialog(any()))
          .thenAnswer((_) async => const CustomDialogResponse(buttonIndexPressed: 0));

      when(() => mockAppInfoService.applicationName).thenReturn('');
      when(() => mockAppInfoService.applicationVersion).thenReturn('');
      when(() => mockAppInfoService.applicationLegalese).thenReturn('');

      await tester.tap(button);
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
