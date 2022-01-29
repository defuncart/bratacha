abstract class BaseDialogRequest {
  const BaseDialogRequest({
    required this.title,
    this.isModal = false,
  });

  final String title;
  final bool isModal;

  @override
  String toString() => 'title: $title, isModal: $isModal';
}
