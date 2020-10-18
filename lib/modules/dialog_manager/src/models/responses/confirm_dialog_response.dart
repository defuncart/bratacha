import 'base_dialog_response.dart';

class ConfirmDialogResponse extends BaseDialogResponse {
  final bool isPositive;

  const ConfirmDialogResponse.positive()
      : isPositive = true,
        super();

  const ConfirmDialogResponse.negative()
      : isPositive = false,
        super();

  const ConfirmDialogResponse.hasError()
      : isPositive = null,
        super(hasError: true);

  @override
  String toString() => '{${super.toString()}, isPositive: $isPositive}';
}
