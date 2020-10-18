abstract class BaseDialogResponse {
  final bool hasError;

  const BaseDialogResponse({bool hasError}) : hasError = hasError ?? false;

  @override
  String toString() => 'hasError: $hasError';
}
