import 'package:meta/meta.dart';

abstract class BaseDialogRequest {
  final String title;
  final bool isModal;

  const BaseDialogRequest({
    @required this.title,
    bool isModal = false,
  })  : assert(title != null),
        isModal = isModal ?? false;

  @override
  String toString() => 'title: $title, isModal: $isModal';
}
