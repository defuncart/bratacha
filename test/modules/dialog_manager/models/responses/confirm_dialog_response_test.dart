import 'package:bratacha/modules/dialog_manager/dialog_manager.dart' show ConfirmDialogResponse;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$ConfirmDialogResponse', () {
    test('Ensure toString is overridden', () {
      final response = ConfirmDialogResponse.positive();

      expect(response.toString(), isNot('hasError: false'));
      expect(response.toString(), isNot('Instance of \'ConfirmDialogResponse\''));
    });

    test('Ensure constructor hasError is correct', () {
      final response = ConfirmDialogResponse.hasError();

      expect(response.hasError, isTrue);
      expect(() => response.isPositive, throwsStateError);
    });

    test('Ensure constructor positive is correct', () {
      final response = ConfirmDialogResponse.positive();

      expect(response.hasError, isFalse);
      expect(response.isPositive, isTrue);
    });

    test('Ensure constructor negative is correct', () {
      final response = ConfirmDialogResponse.negative();

      expect(response.hasError, isFalse);
      expect(response.isPositive, isFalse);
    });
  });
}
