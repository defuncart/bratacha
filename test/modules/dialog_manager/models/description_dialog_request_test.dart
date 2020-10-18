import 'package:bratacha/modules/dialog_manager/src/models/description_dialog_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

void main() {
  test('All subclasses must supply non-null description', () {
    expect(
      () => _MockRequest(
        title: 'Title',
        description: null,
      ),
      throwsAssertionError,
    );
  });
}

class _MockRequest extends DescriptionDialogRequest {
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
