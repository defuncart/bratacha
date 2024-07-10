import 'package:flutter/widgets.dart';

import 'base_dialog_request.dart';

class CustomDialogRequest extends BaseDialogRequest {
  const CustomDialogRequest({
    required super.title,
    required this.content,
    required this.buttonTexts,
    super.isModal,
  }) : assert(buttonTexts.length > 0);

  final Widget content;
  final List<String> buttonTexts;

  @override
  String toString() => '{${super.toString()}, content: ${content.runtimeType}, buttonTexts: $buttonTexts}';
}
