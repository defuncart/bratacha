import 'package:bratacha/modules/dialog_manager/src/models/base_dialog_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

void main() {
  test('All subclasses must supply non-null title', () {
    expect(
      () => _MockRequest(
        title: null,
        description: 'Description',
      ),
      throwsAssertionError,
    );
  });

  test('All subclasses must supply non-null description', () {
    expect(
      () => _MockRequest(
        title: 'Title',
        description: null,
      ),
      throwsAssertionError,
    );
  });

  test('isModal defaults to false, even if null is passed', () {
    final request = _MockRequest(
      title: 'Title',
      description: 'Description',
      isModal: null,
    );
    expect(request.isModal, isFalse);
  });
}

class _MockRequest extends BaseDialogRequest {
  const _MockRequest({
    @required String title,
    @required String description,
    bool isModal = false,
  }) : super(
          title: title,
          description: description,
          isModal: isModal,
        );
}
