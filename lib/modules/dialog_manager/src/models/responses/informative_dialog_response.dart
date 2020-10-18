import 'base_dialog_response.dart';

class InformativeDialogResponse extends BaseDialogResponse {
  const InformativeDialogResponse() : super();

  const InformativeDialogResponse.hasError() : super(hasError: true);

  @override
  String toString() => '{${super.toString()}}';
}
