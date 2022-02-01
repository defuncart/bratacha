import '../models/requests/base_dialog_request.dart';
import '../models/requests/confirm_dialog_request.dart';
import '../models/requests/custom_dialog_request.dart';
import '../models/requests/informative_dialog_request.dart';
import '../models/responses/base_dialog_response.dart';
import '../models/responses/confirm_dialog_response.dart';
import '../models/responses/custom_dialog_response.dart';
import '../models/responses/informative_dialog_response.dart';

abstract class IDialogService {
  Stream<BaseDialogRequest> get requestStream;

  Future<InformativeDialogResponse> requestInformativeDialog(InformativeDialogRequest request);

  Future<ConfirmDialogResponse> requestConfirmDialog(ConfirmDialogRequest request);

  Future<CustomDialogResponse> requestCustomDialog(CustomDialogRequest request);

  void dialogClosedByUser({required BaseDialogResponse response});
}
