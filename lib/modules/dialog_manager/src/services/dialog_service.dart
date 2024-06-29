import 'dart:async';

import '../models/requests/base_dialog_request.dart';
import '../models/requests/confirm_dialog_request.dart';
import '../models/requests/custom_dialog_request.dart';
import '../models/requests/informative_dialog_request.dart';
import '../models/responses/base_dialog_response.dart';
import '../models/responses/confirm_dialog_response.dart';
import '../models/responses/custom_dialog_response.dart';
import '../models/responses/informative_dialog_response.dart';
import 'i_dialog_service.dart';

class DialogService implements IDialogService {
  Completer? _dialogCompleter;

  bool get _isCurrentlyPresenting => _dialogCompleter != null;

  final _requestStreamController = StreamController<BaseDialogRequest>.broadcast();

  @override
  Stream<BaseDialogRequest> get requestStream => _requestStreamController.stream;

  @override
  Future<InformativeDialogResponse> requestInformativeDialog(InformativeDialogRequest request) {
    if (_isCurrentlyPresenting) {
      return Future.value(const InformativeDialogResponse.hasError());
    }

    _dialogCompleter = Completer<InformativeDialogResponse>();
    _requestStreamController.add(request);
    return _dialogCompleter!.future as Future<InformativeDialogResponse>;
  }

  @override
  Future<ConfirmDialogResponse> requestConfirmDialog(ConfirmDialogRequest request) {
    if (_isCurrentlyPresenting) {
      return Future.value(const ConfirmDialogResponse.hasError());
    }

    _dialogCompleter = Completer<ConfirmDialogResponse>();
    _requestStreamController.add(request);
    return _dialogCompleter!.future as Future<ConfirmDialogResponse>;
  }

  @override
  Future<CustomDialogResponse> requestCustomDialog(CustomDialogRequest request) {
    if (_isCurrentlyPresenting) {
      return Future.value(const CustomDialogResponse.hasError());
    }

    _dialogCompleter = Completer<CustomDialogResponse>();
    _requestStreamController.add(request);
    return _dialogCompleter!.future as Future<CustomDialogResponse>;
  }

  @override
  void dialogClosedByUser({required BaseDialogResponse response}) {
    if (_dialogCompleter != null) {
      _dialogCompleter!.complete(response);
      _dialogCompleter = null;
    }
  }
}
