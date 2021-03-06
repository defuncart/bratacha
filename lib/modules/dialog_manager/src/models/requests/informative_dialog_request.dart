import 'package:meta/meta.dart';

import 'description_dialog_request.dart';

class InformativeDialogRequest extends DescriptionDialogRequest {
  final String buttonText;

  const InformativeDialogRequest({
    @required String title,
    @required String description,
    @required this.buttonText,
    bool isModal = false,
  })  : assert(buttonText != null),
        super(
          title: title,
          description: description,
          isModal: isModal,
        );

  @override
  String toString() => '{${super.toString()}, buttonText: $buttonText}';
}
