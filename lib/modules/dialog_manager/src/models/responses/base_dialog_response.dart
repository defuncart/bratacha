abstract class BaseDialogResponse {
  final bool hasError;

  const BaseDialogResponse({this.hasError = false});

  @override
  String toString() => 'hasError: $hasError';
}
