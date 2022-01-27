import 'package:flutter/widgets.dart';

import 'base_dialog_request.dart';

class CustomDialogRequest extends BaseDialogRequest {
  final Widget content;
  final List<String> buttonTexts;

  const CustomDialogRequest({
    required String title,
    required this.content,
    required this.buttonTexts,
    bool isModal = false,
  })  : assert(buttonTexts.length > 0),
        super(
          title: title,
          isModal: isModal,
        );

  @override
  String toString() => '{${super.toString()}, content: ${content.runtimeType}, buttonTexts: $buttonTexts}';
}
