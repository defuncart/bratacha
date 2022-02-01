abstract class BaseDialogResponse {
  const BaseDialogResponse({
    this.hasError = false,
  });

  final bool hasError;

  @override
  String toString() => 'hasError: $hasError';
}
