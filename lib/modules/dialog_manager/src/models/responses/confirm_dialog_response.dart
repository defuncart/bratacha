import 'base_dialog_response.dart';

class ConfirmDialogResponse extends BaseDialogResponse {
  const ConfirmDialogResponse.positive()
      : _isPositive = true,
        super();

  const ConfirmDialogResponse.negative()
      : _isPositive = false,
        super();

  const ConfirmDialogResponse.hasError()
      : _isPositive = null,
        super(hasError: true);

  final bool? _isPositive;
  bool get isPositive {
    if (_isPositive == null) {
      throw StateError('isPositive should not be accessed when hasError');
    }

    return _isPositive!;
  }

  @override
  String toString() => '{${super.toString()}, isPositive: $isPositive}';
}
