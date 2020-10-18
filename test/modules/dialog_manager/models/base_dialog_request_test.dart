import 'package:bratacha/modules/dialog_manager/src/models/base_dialog_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

void main() {
  test('All subclasses must supply non-null title', () {
    expect(
      () => _MockRequest(
        title: null,
      ),
      throwsAssertionError,
    );
  });

  test('isModal defaults to false, even if null is passed', () {
    final request = _MockRequest(
      title: 'Title',
      isModal: null,
    );
    expect(request.isModal, isFalse);
  });
}

class _MockRequest extends BaseDialogRequest {
  const _MockRequest({
    @required String title,
    bool isModal = false,
  }) : super(
          title: title,
          isModal: isModal,
        );
}
