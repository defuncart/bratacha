import 'package:meta/meta.dart';

import 'description_dialog_request.dart';

class ConfirmDialogRequest extends DescriptionDialogRequest {
  final String negativeButtonText;
  final String positiveButtonText;

  const ConfirmDialogRequest({
    @required String title,
    @required String description,
    @required this.negativeButtonText,
    @required this.positiveButtonText,
    bool isModal = false,
  })  : assert(negativeButtonText != null),
        assert(positiveButtonText != null),
        super(
          title: title,
          description: description,
          isModal: isModal,
        );

  @override
  String toString() =>
      '{${super.toString()}, negativeButtonText: $negativeButtonText, positiveButtonText: $positiveButtonText}';
}
