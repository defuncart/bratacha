import 'description_dialog_request.dart';

class ConfirmDialogRequest extends DescriptionDialogRequest {
  const ConfirmDialogRequest({
    required super.title,
    required super.description,
    required this.negativeButtonText,
    required this.positiveButtonText,
    super.isModal,
  });

  final String negativeButtonText;
  final String positiveButtonText;

  @override
  String toString() =>
      '{${super.toString()}, negativeButtonText: $negativeButtonText, positiveButtonText: $positiveButtonText}';
}
