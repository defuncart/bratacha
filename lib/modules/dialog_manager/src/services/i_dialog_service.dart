import 'package:meta/meta.dart';

import '../enums/confirm_dialog_response_type.dart';
import '../models/requests/base_dialog_request.dart';
import '../models/requests/confirm_dialog_request.dart';
import '../models/requests/custom_dialog_request.dart';
import '../models/requests/informative_dialog_request.dart';

abstract class IDialogService {
  Stream<BaseDialogRequest> get requestStream;

  Future<void> requestInformativeDialog(InformativeDialogRequest request);

  Future<ConfirmDialogResponseType> requestConfirmDialog(ConfirmDialogRequest request);

  void dialogClosedByUser({@required Type type, dynamic data});
}
