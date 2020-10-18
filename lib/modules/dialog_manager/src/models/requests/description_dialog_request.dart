import 'package:meta/meta.dart';

import 'base_dialog_request.dart';

/// Request for a dialog which contains a title and string description.
abstract class DescriptionDialogRequest extends BaseDialogRequest {
  final String description;

  const DescriptionDialogRequest({
    @required String title,
    @required this.description,
    bool isModal = false,
  })  : assert(description != null),
        super(
          title: title,
          isModal: isModal,
        );

  @override
  String toString() => '${super.toString()}, description: $description';
}
