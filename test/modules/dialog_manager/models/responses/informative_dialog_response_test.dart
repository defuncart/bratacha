import 'package:bratacha/modules/dialog_manager/dialog_manager.dart' show InformativeDialogResponse;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$InformativeDialogResponse', () {
    test('Ensure toString is overridden', () {
      final response = InformativeDialogResponse();

      expect(response.toString(), isNot('hasError: false'));
      expect(response.toString(), isNot('Instance of \'InformativeDialogResponse\''));
    });

    test('Ensure constructor hasError is correct', () {
      final response = InformativeDialogResponse.hasError();

      expect(response.hasError, isTrue);
    });
  });
}
