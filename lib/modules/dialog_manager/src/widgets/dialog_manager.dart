import 'dart:async';

import 'package:flutter/material.dart';

import '../enums/confirm_dialog_response_type.dart';
import '../models/base_dialog_request.dart';
import '../models/confirm_dialog_request.dart';
import '../models/informative_dialog_request.dart';
import '../services/i_dialog_service.dart';

class DialogManager extends StatefulWidget {
  final IDialogService dialogService;
  final Widget child;

  DialogManager({
    Key key,
    @required this.dialogService,
    @required this.child,
  })  : assert(dialogService != null),
        assert(child != null),
        super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = widget.dialogService.requestStream.listen((request) async => await _processRequest(request));
  }

  @override
  void dispose() {
    _subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  Future<void> _processRequest(BaseDialogRequest request) async {
    Widget content;
    List<Widget> actions;
    ConfirmDialogResponseType responseType;

    if (request is InformativeDialogRequest) {
      content = Text(request.description);
      actions = [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(request.buttonText.toUpperCase()),
        ),
      ];
    } else if (request is ConfirmDialogRequest) {
      content = Text(request.description);
      actions = [
        TextButton(
          onPressed: () {
            responseType = ConfirmDialogResponseType.negative;
            Navigator.of(context).pop();
          },
          child: Text(request.negativeButtonText.toUpperCase()),
        ),
        TextButton(
          onPressed: () {
            responseType = ConfirmDialogResponseType.positive;
            Navigator.of(context).pop();
          },
          child: Text(request.positiveButtonText.toUpperCase()),
        ),
      ];
    }

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(request.title),
        content: content,
        actions: actions,
      ),
      barrierDismissible: !request.isModal,
    );

    if (request is ConfirmDialogRequest) {
      responseType ??= ConfirmDialogResponseType.negative;
    }

    widget.dialogService.dialogClosedByUser(type: request.runtimeType, data: responseType);
  }
}
