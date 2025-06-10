import 'base_dialog_response.dart';

class CustomDialogResponse extends BaseDialogResponse {
  const CustomDialogResponse({required this.buttonIndexPressed}) : super();

  const CustomDialogResponse.hasError() : buttonIndexPressed = -1, super(hasError: true);

  final int buttonIndexPressed;

  @override
  String toString() => '{${super.toString()}, buttonIndexPressed: $buttonIndexPressed}';
}
