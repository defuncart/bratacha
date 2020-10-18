import 'package:meta/meta.dart';

import 'base_dialog_response.dart';

class CustomDialogResponse extends BaseDialogResponse {
  final int buttonIndexPressed;

  const CustomDialogResponse({@required this.buttonIndexPressed}) : super();

  const CustomDialogResponse.hasError()
      : buttonIndexPressed = null,
        super(hasError: true);

  @override
  String toString() => '{${super.toString()}, buttonIndexPressed: $buttonIndexPressed}';
}
