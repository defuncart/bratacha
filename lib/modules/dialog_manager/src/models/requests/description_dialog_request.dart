import 'base_dialog_request.dart';

/// Request for a dialog which contains a title and string description.
abstract class DescriptionDialogRequest extends BaseDialogRequest {
  const DescriptionDialogRequest({
    required String title,
    required this.description,
    bool isModal = false,
  }) : super(
          title: title,
          isModal: isModal,
        );

  final String description;

  @override
  String toString() => '${super.toString()}, description: $description';
}
