import 'dart:async';

import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/dialog_manager/src/models/requests/base_dialog_request.dart';
import 'package:bratacha/modules/dialog_manager/src/models/responses/base_dialog_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  test('dialogService null value triggers assertion', () {
    expect(
      () => DialogManager(
        dialogService: null,
        child: Container(),
      ),
      throwsAssertionError,
    );
  });

  test('child null value triggers assertion', () {
    expect(
      () => DialogManager(
        dialogService: DialogService(),
        child: null,
      ),
      throwsAssertionError,
    );
  });

  testWidgets('', (tester) async {
    final dialogService = _MockDialogService();
    final widget = DialogManager(
      dialogService: dialogService,
      child: Container(),
    );

    await tester.pumpWidget(MaterialApp(home: widget));

    // ignore: unawaited_futures
    dialogService.requestInformativeDialog(
      InformativeDialogRequest(title: 'A', description: 'B', buttonText: 'C'),
    );

    // ignore: unawaited_futures
    dialogService.requestConfirmDialog(
      ConfirmDialogRequest(title: 'A', description: 'B', negativeButtonText: 'C', positiveButtonText: 'D'),
    );

    // ignore: unawaited_futures
    dialogService.requestCustomDialog(
      CustomDialogRequest(title: 'A', content: Container(), buttonTexts: ['B']),
    );
  });
}

class _MockDialogService extends Mock implements IDialogService {
  final _requestStreamController = StreamController<BaseDialogRequest>();

  @override
  Stream<BaseDialogRequest> get requestStream => _requestStreamController.stream;

  @override
  Future<InformativeDialogResponse> requestInformativeDialog(InformativeDialogRequest request) {
    _requestStreamController.add(request);
    return Future.value(InformativeDialogResponse());
  }

  @override
  Future<ConfirmDialogResponse> requestConfirmDialog(ConfirmDialogRequest request) {
    _requestStreamController.add(request);
    return Future.value(ConfirmDialogResponse.positive());
  }

  @override
  Future<CustomDialogResponse> requestCustomDialog(CustomDialogRequest request) {
    _requestStreamController.add(request);
    return Future.value(CustomDialogResponse(buttonIndexPressed: null));
  }

  @override
  void dialogClosedByUser({@required BaseDialogResponse response}) {
    // _dialogCompleter.complete(response);
    // _dialogCompleter = null;
  }
}
