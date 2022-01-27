abstract class BaseDialogRequest {
  final String title;
  final bool isModal;

  const BaseDialogRequest({
    required this.title,
    this.isModal = false,
  });

  @override
  String toString() => 'title: $title, isModal: $isModal';
}
