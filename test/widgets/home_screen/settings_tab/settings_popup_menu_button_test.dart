// import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
// import 'package:bratacha/modules/dialog_manager/src/models/responses/base_dialog_response.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
// import 'package:bratacha/services/app_info_service/i_app_info_service.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/settings_popup_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../test_utils.dart';

void main() {
  group('$SettingsPopupMenuButton', () {
    final playerDataService = _MockPlayerDataService();
    final widget = MultiBlocProvider(
      providers: [
        BlocProvider<HardDifficultyCubit>(
          create: (_) => HardDifficultyCubit(playerDataService),
        ),
        BlocProvider<LanguageCubit>(
          create: (_) => LanguageCubit(playerDataService),
        ),
      ],
      child: SettingsPopupMenuButton(parentContext: MockBuildContext()),
    );

    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          Scaffold(body: widget),
        ),
      );

      expect(find.byType(SettingsPopupMenuButton), findsOneWidget);
    });

    testWidgets('Clicking on button opens popup menu', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          Scaffold(body: widget),
        ),
      );

      final button = find.byType(SettingsPopupMenuButton);
      await tester.tap(button);
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(SettingsPopupMenuButton));
      expect(find.text(context.l10n.settingsTabDataPrivacyLabel), findsOneWidget);
      expect(find.text(context.l10n.settingsTabCreditsLabel), findsOneWidget);
    });

    // testWidgets('Ensure data privacy button is clickable', (tester) async {
    //   final mockDialogService = MockDialogService();

    //   await tester.pumpWidget(
    //     wrapWithMaterialApp(
    //       MultiRepositoryProvider(
    //         providers: [
    //           RepositoryProvider<IDialogService>.value(
    //             value: mockDialogService,
    //           ),
    //           // RepositoryProvider<IAppInfoService>(
    //           //   create: (_) => _MockAppInfoService(),
    //           // ),
    //         ],
    //         child: widget,
    //       ),
    //     ),
    //   );

    // final button = find.byType(PopupMenuItem).at(0);

    // mockDialogService.setResponse(CustomDialogResponse(buttonIndexPressed: 1));

    // await tester.tap(button);

    // dialogService.setResponse(CustomDialogResponse(buttonIndexPressed: 0));

    // await tester.tap(button);
    // });

    // testWidgets('Ensure credits button is clickable', (tester) async {
    //   await tester.pumpWidget(
    //     MultiRepositoryProvider(
    //       providers: [
    //         RepositoryProvider<IDialogService>(
    //           create: (_) => dialogService,
    //         ),
    //       ],
    //       child: MaterialApp(home: widget),
    //     ),
    //   );

    //   final button = find.byType(CustomElevatedButton).at(2);

    //   dialogService.setResponse(CustomDialogResponse(buttonIndexPressed: 0));

    //   await tester.tap(button);
    // });
  });
}

class _MockPlayerDataService extends Mock implements IPlayerDataService {
  @override
  String get language => 'en';

  @override
  bool get isHardDifficulty => false;
}

// class _MockDialogService extends Mock implements IDialogService {
//   BaseDialogResponse _response;

//   void setResponse(BaseDialogResponse response) => _response = response;

//   @override
//   Future<InformativeDialogResponse> requestInformativeDialog(InformativeDialogRequest request) async =>
//       await Future.value(_response as InformativeDialogResponse);

//   @override
//   Future<ConfirmDialogResponse> requestConfirmDialog(ConfirmDialogRequest request) async =>
//       await Future.value(_response as ConfirmDialogResponse);

//   @override
//   Future<CustomDialogResponse> requestCustomDialog(CustomDialogRequest request) async =>
//       await Future.value(_response as CustomDialogResponse);
// }

// class _MockAppInfoService extends Mock implements IAppInfoService {}


