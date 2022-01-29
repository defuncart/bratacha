import 'package:bratacha/modules/dialog_manager/dialog_manager.dart' show CustomDialogResponse;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$CustomDialogResponse', () {
    test('Ensure toString is overridden', () {
      const response = CustomDialogResponse(buttonIndexPressed: 0);

      expect(response.toString(), isNot('hasError: false'));
      expect(response.toString(), isNot('Instance of \'CustomDialogResponse\''));
    });

    test('Ensure constructor hasError is correct', () {
      const response = CustomDialogResponse.hasError();

      expect(response.hasError, isTrue);
      expect(response.buttonIndexPressed, -1);
    });

    test('Ensure constructor is correct', () {
      const response = CustomDialogResponse(buttonIndexPressed: 0);

      expect(response.hasError, isFalse);
      expect(response.buttonIndexPressed, 0);
    });
  });
}
