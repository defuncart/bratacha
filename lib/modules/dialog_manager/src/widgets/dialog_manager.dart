import 'dart:async';

import 'package:flutter/material.dart';

import '../models/requests/base_dialog_request.dart';
import '../models/requests/confirm_dialog_request.dart';
import '../models/requests/custom_dialog_request.dart';
import '../models/requests/informative_dialog_request.dart';
import '../models/responses/base_dialog_response.dart';
import '../models/responses/confirm_dialog_response.dart';
import '../models/responses/custom_dialog_response.dart';
import '../models/responses/informative_dialog_response.dart';
import '../services/i_dialog_service.dart';

class DialogManager extends StatefulWidget {
  const DialogManager({
    required this.dialogService,
    required this.child,
    Key? key,
  }) : super(key: key);

  final IDialogService dialogService;
  final Widget child;

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  StreamSubscription<BaseDialogRequest>? _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = widget.dialogService.requestStream.listen((request) async => await _processRequest(request));
  }

  @override
  void dispose() {
    _subscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  Future<void> _processRequest(BaseDialogRequest request) async {
    late Widget content;
    late List<Widget> actions;
    BaseDialogResponse? response;

    if (request is InformativeDialogRequest) {
      content = Text(request.description);
      actions = [
        TextButton(
          onPressed: () {
            response = const InformativeDialogResponse();
            Navigator.of(context).pop();
          },
          child: Text(request.buttonText.toUpperCase()),
        ),
      ];
    } else if (request is ConfirmDialogRequest) {
      content = Text(request.description);
      actions = [
        TextButton(
          onPressed: () {
            response = const ConfirmDialogResponse.negative();
            Navigator.of(context).pop();
          },
          child: Text(request.negativeButtonText.toUpperCase()),
        ),
        TextButton(
          onPressed: () {
            response = const ConfirmDialogResponse.positive();
            Navigator.of(context).pop();
          },
          child: Text(request.positiveButtonText.toUpperCase()),
        ),
      ];
    } else if (request is CustomDialogRequest) {
      content = request.content;
      actions = [
        for (var i = 0; i < request.buttonTexts.length; i++)
          TextButton(
            onPressed: () {
              response = CustomDialogResponse(buttonIndexPressed: i);
              Navigator.of(context).pop();
            },
            child: Text(request.buttonTexts[i].toUpperCase()),
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

    // account for the fact that dialog may be dismiss if !isModal
    if (response == null) {
      if (request is InformativeDialogRequest) {
        response = const InformativeDialogResponse();
      } else if (request is ConfirmDialogRequest) {
        response = const ConfirmDialogResponse.negative();
      } else if (request is CustomDialogRequest) {
        response = const CustomDialogResponse(buttonIndexPressed: -1);
      }
    }

    widget.dialogService.dialogClosedByUser(response: response!);
  }
}
