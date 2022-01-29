import 'package:bratacha/modules/dialog_manager/dialog_manager.dart' show CustomDialogResponse;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$CustomDialogResponse', () {
    test('Ensure toString is overridden', () {
      final response = CustomDialogResponse(buttonIndexPressed: 0);

      expect(response.toString(), isNot('hasError: false'));
      expect(response.toString(), isNot('Instance of \'CustomDialogResponse\''));
    });

    test('Ensure constructor hasError is correct', () {
      final response = CustomDialogResponse.hasError();

      expect(response.hasError, isTrue);
      expect(response.buttonIndexPressed, -1);
    });

    test('Ensure constructor is correct', () {
      final response = CustomDialogResponse(buttonIndexPressed: 0);

      expect(response.hasError, isFalse);
      expect(response.buttonIndexPressed, 0);
    });
  });
}
