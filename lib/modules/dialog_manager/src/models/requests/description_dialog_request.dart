import 'base_dialog_request.dart';

/// Request for a dialog which contains a title and string description.
abstract class DescriptionDialogRequest extends BaseDialogRequest {
  const DescriptionDialogRequest({
    required super.title,
    required this.description,
    super.isModal,
  });

  final String description;

  @override
  String toString() => '${super.toString()}, description: $description';
}
