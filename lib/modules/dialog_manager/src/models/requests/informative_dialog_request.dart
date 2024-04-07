import 'description_dialog_request.dart';

class InformativeDialogRequest extends DescriptionDialogRequest {
  const InformativeDialogRequest({
    required super.title,
    required super.description,
    required this.buttonText,
    super.isModal,
  });

  final String buttonText;

  @override
  String toString() => '{${super.toString()}, buttonText: $buttonText}';
}
