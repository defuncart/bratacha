import 'package:bratacha/modules/dialog_manager/dialog_manager.dart' show InformativeDialogRequest;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$InformativeDialogRequest', () {
    test('toString is overridden', () {
      final request = InformativeDialogRequest(
        title: 'Title',
        description: 'Description',
        buttonText: 'Ok',
      );

      expect(request.toString(), isNotNull);
      expect(request.toString(), isNot('title: Title, description: Description, isModal: false'));
      expect(request.toString(), isNot('Instance of \'InformativeDialogRequest\''));
    });

    test('Ensure parameters correctly set', () {
      final title = 'Title';
      final description = 'Description';
      final buttonText = 'Ok';

      final request = InformativeDialogRequest(
        title: title,
        description: description,
        buttonText: buttonText,
      );

      expect(request.title, title);
      expect(request.description, description);
      expect(request.buttonText, buttonText);
      expect(request.isModal, isFalse);
    });
  });
}
