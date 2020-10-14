import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/dialog_manager/src/models/base_dialog_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('requestInformativeDialog', () async {
    final dialogService = DialogService();

    BaseDialogRequest request;
    final subscription = dialogService.requestStream.listen((event) => request = event);

    Future.delayed(Duration(milliseconds: 100), () {
      expect(request is InformativeDialogRequest, isTrue);
      dialogService.dialogClosedByUser(type: request.runtimeType);
    });

    await dialogService.requestInformativeDialog(
      InformativeDialogRequest(title: 'A', description: 'B', buttonText: 'C'),
    );

    await subscription.cancel();
  });

  test('requestConfirmDialog', () async {
    final dialogService = DialogService();

    BaseDialogRequest request;
    final subscription = dialogService.requestStream.listen((event) => request = event);

    Future.delayed(Duration(milliseconds: 100), () {
      expect(request is ConfirmDialogRequest, isTrue);
      dialogService.dialogClosedByUser(type: request.runtimeType, data: ConfirmDialogResponseType.negative);
    });

    final response = await dialogService.requestConfirmDialog(
      ConfirmDialogRequest(title: 'A', description: 'B', negativeButtonText: 'C', positiveButtonText: 'D'),
    );

    expect(response, ConfirmDialogResponseType.negative);

    await subscription.cancel();
  });

  // test('requestConfirmDialog', () {
  //   final dialogService = DialogService();

  //   dialogService.requestInformativeDialog(
  //     InformativeDialogRequest(title: 'A', description: 'B', buttonText: 'C'),
  //   );

  //   expect(
  //     () async => await dialogService.requestInformativeDialog(
  //       InformativeDialogRequest(title: 'A', description: 'B', buttonText: 'C'),
  //     ),
  //     throwsException,
  //   );
  // });
}
