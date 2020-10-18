import 'package:meta/meta.dart';

import '../enums/confirm_dialog_response_type.dart';
import '../models/base_dialog_request.dart';
import '../models/confirm_dialog_request.dart';
import '../models/informative_dialog_request.dart';

abstract class IDialogService {
  Stream<BaseDialogRequest> get requestStream;

  Future<void> requestInformativeDialog(InformativeDialogRequest request);

  Future<ConfirmDialogResponseType> requestConfirmDialog(ConfirmDialogRequest request);

  void dialogClosedByUser({@required Type type, dynamic data});
}
