import 'package:meta/meta.dart';

abstract class BaseDialogRequest {
  final String title;
  final String description;
  final bool isModal;

  const BaseDialogRequest({
    @required this.title,
    @required this.description,
    bool isModal = false,
  })  : assert(title != null),
        assert(description != null),
        isModal = isModal ?? false;

  @override
  String toString() => 'title: $title, description: $description, isModal: $isModal';
}
