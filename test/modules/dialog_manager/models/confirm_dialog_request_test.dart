import 'package:bratacha/modules/dialog_manager/dialog_manager.dart' show ConfirmDialogRequest;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toString is overridden', () {
    final request = ConfirmDialogRequest(
      title: 'Title',
      description: 'Description',
      negativeButtonText: 'No',
      positiveButtonText: 'Yes',
    );

    expect(request.toString(), isNotNull);
    expect(request.toString(), isNot('title: Title, description: Description, isModal: false'));
    expect(request.toString(), isNot('Instance of \'ConfirmDialogRequest\''));
  });

  test('Ensure parameters correctly set', () {
    final title = 'Title';
    final description = 'Description';
    final negativeButtonText = 'No';
    final positiveButtonText = 'Yes';

    final request = ConfirmDialogRequest(
      title: title,
      description: description,
      negativeButtonText: negativeButtonText,
      positiveButtonText: positiveButtonText,
    );

    expect(request.title, title);
    expect(request.description, description);
    expect(request.negativeButtonText, negativeButtonText);
    expect(request.positiveButtonText, positiveButtonText);
    expect(request.isModal, isFalse);
  });

  test('Null negativeButtonText throws assertion', () {
    expect(
      () => ConfirmDialogRequest(
        title: 'Title',
        description: 'Description',
        negativeButtonText: null,
        positiveButtonText: 'Yes',
      ),
      throwsAssertionError,
    );
  });

  test('Null negativeButtonText throws assertion', () {
    expect(
      () => ConfirmDialogRequest(
        title: 'Title',
        description: 'Description',
        negativeButtonText: 'No',
        positiveButtonText: null,
      ),
      throwsAssertionError,
    );
  });
}
