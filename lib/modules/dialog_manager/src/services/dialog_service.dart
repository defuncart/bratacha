import 'dart:async';

import 'package:meta/meta.dart';

import '../enums/confirm_dialog_response_type.dart';
import '../models/requests/base_dialog_request.dart';
import '../models/requests/confirm_dialog_request.dart';
import '../models/requests/custom_dialog_request.dart';
import '../models/requests/informative_dialog_request.dart';
import 'i_dialog_service.dart';

class DialogService implements IDialogService {
  Completer _dialogCompleter;

  bool get _isCurrentlyPresenting => _dialogCompleter != null;

  final _requestStreamController = StreamController<BaseDialogRequest>();

  @override
  Stream<BaseDialogRequest> get requestStream => _requestStreamController.stream;

  @override
  Future<void> requestInformativeDialog(InformativeDialogRequest request) {
    if (_isCurrentlyPresenting) {
      _dialogCompleter.completeError(Error());
    }

    _dialogCompleter = Completer();
    _requestStreamController.add(request);
    return _dialogCompleter.future;
  }

  @override
  Future<ConfirmDialogResponseType> requestConfirmDialog(ConfirmDialogRequest request) {
    if (_isCurrentlyPresenting) {
      _dialogCompleter.completeError(Error());
    }

    _dialogCompleter = Completer<ConfirmDialogResponseType>();
    _requestStreamController.add(request);
    return _dialogCompleter.future;
  }

  @override
  void dialogClosedByUser({@required Type type, dynamic data}) {
    if (type == InformativeDialogRequest) {
      _dialogCompleter.complete();
    } else if (type == ConfirmDialogRequest) {
      _dialogCompleter.complete(data as ConfirmDialogResponseType);
    }

    _dialogCompleter = null;
  }
}
