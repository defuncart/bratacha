import 'package:bratacha/modules/dialog_manager/src/models/requests/base_dialog_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$BaseDialogRequest', () {
    test('isModal defaults to false, even if null is passed', () {
      final request = _MockRequest(
        title: 'Title',
      );
      expect(request.isModal, isFalse);
    });
  });
}

class _MockRequest extends BaseDialogRequest {
  const _MockRequest({
    required String title,
    bool isModal = false,
  }) : super(
          title: title,
          isModal: isModal,
        );
}
