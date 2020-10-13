import 'package:meta/meta.dart';

// ignore_for_file: always_use_package_imports
import '../enums/confirm_dialog_response_type.dart';
import '../models/base_dialog_request.dart';

abstract class IDialogService {
  Stream<BaseDialogRequest> get requestStream;

  Future<void> requestInformativeDialog();

  Future<ConfirmDialogResponseType> requestConfirmDialog();

  void dialogClosedByUser({@required Type type, dynamic data});
}
