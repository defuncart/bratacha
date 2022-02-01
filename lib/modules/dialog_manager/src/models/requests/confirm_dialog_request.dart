import 'description_dialog_request.dart';

class ConfirmDialogRequest extends DescriptionDialogRequest {
  const ConfirmDialogRequest({
    required String title,
    required String description,
    required this.negativeButtonText,
    required this.positiveButtonText,
    bool isModal = false,
  }) : super(
          title: title,
          description: description,
          isModal: isModal,
        );

  final String negativeButtonText;
  final String positiveButtonText;

  @override
  String toString() =>
      '{${super.toString()}, negativeButtonText: $negativeButtonText, positiveButtonText: $positiveButtonText}';
}
