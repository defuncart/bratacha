import 'base_dialog_response.dart';

class CustomDialogResponse extends BaseDialogResponse {
  final int buttonIndexPressed;

  const CustomDialogResponse({required this.buttonIndexPressed}) : super();

  const CustomDialogResponse.hasError()
      : buttonIndexPressed = -1,
        super(hasError: true);

  @override
  String toString() => '{${super.toString()}, buttonIndexPressed: $buttonIndexPressed}';
}
