import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/dialog_manager/src/models/requests/base_dialog_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$DialogService', () {
    test('requestInformativeDialog', () async {
      final dialogService = DialogService();

      late BaseDialogRequest request;
      final subscription = dialogService.requestStream.listen((event) => request = event);

      Future.delayed(const Duration(milliseconds: 100), () {
        expect(request is InformativeDialogRequest, isTrue);
        dialogService.dialogClosedByUser(response: const InformativeDialogResponse());
      });

      final response = await dialogService.requestInformativeDialog(
        const InformativeDialogRequest(title: 'A', description: 'B', buttonText: 'C'),
      );

      expect(response, isA<InformativeDialogResponse>());

      await subscription.cancel();
    });

    test('requestConfirmDialog', () async {
      final dialogService = DialogService();

      late BaseDialogRequest request;
      final subscription = dialogService.requestStream.listen((event) => request = event);

      Future.delayed(const Duration(milliseconds: 100), () {
        expect(request is ConfirmDialogRequest, isTrue);
        dialogService.dialogClosedByUser(response: const ConfirmDialogResponse.positive());
      });

      final response = await dialogService.requestConfirmDialog(
        const ConfirmDialogRequest(title: 'A', description: 'B', negativeButtonText: 'C', positiveButtonText: 'D'),
      );

      expect(response, isA<ConfirmDialogResponse>());
      expect(response.isPositive, isTrue);

      await subscription.cancel();
    });

    test('customConfirmDialog', () async {
      final dialogService = DialogService();

      late BaseDialogRequest request;
      final subscription = dialogService.requestStream.listen((event) => request = event);

      Future.delayed(const Duration(milliseconds: 100), () {
        expect(request is CustomDialogRequest, isTrue);
        dialogService.dialogClosedByUser(response: const CustomDialogResponse(buttonIndexPressed: 0));
      });

      final response = await dialogService.requestCustomDialog(
        CustomDialogRequest(title: 'A', content: Container(), buttonTexts: ['B']),
      );

      expect(response, isA<CustomDialogResponse>());

      await subscription.cancel();
    });

    test('requestInformativeDialog dialog in progress', () async {
      final dialogService = DialogService();

      // ignore: unawaited_futures
      dialogService.requestInformativeDialog(
        const InformativeDialogRequest(title: 'A', description: 'B', buttonText: 'C'),
      );

      final response = await dialogService.requestInformativeDialog(
        const InformativeDialogRequest(title: 'A', description: 'B', buttonText: 'C'),
      );

      expect(response.hasError, isTrue);
    });

    test('requestConfirmDialog dialog in progress', () async {
      final dialogService = DialogService();

      // ignore: unawaited_futures
      dialogService.requestInformativeDialog(
        const InformativeDialogRequest(title: 'A', description: 'B', buttonText: 'C'),
      );

      final response = await dialogService.requestConfirmDialog(
        const ConfirmDialogRequest(title: 'A', description: 'B', negativeButtonText: 'C', positiveButtonText: 'D'),
      );

      expect(response.hasError, isTrue);
    });

    test('customConfirmDialog dialog in progress', () async {
      final dialogService = DialogService();

      // ignore: unawaited_futures
      dialogService.requestInformativeDialog(
        const InformativeDialogRequest(title: 'A', description: 'B', buttonText: 'C'),
      );

      final response = await dialogService.requestCustomDialog(
        CustomDialogRequest(title: 'A', content: Container(), buttonTexts: ['B']),
      );

      expect(response.hasError, isTrue);
    });
  });
}
