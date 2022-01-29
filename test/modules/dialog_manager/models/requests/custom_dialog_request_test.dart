import 'package:bratacha/modules/dialog_manager/dialog_manager.dart' show CustomDialogRequest;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$CustomDialogRequest', () {
    test('toString is overridden', () {
      final request = CustomDialogRequest(
        title: 'Title',
        content: Container(),
        buttonTexts: [
          'Ok',
        ],
      );

      expect(request.toString(), isNotNull);
      expect(request.toString(), isNot('title: Title, description: Description, isModal: false'));
      expect(request.toString(), isNot('Instance of \'CustomDialogRequest\''));
    });

    test('Ensure parameters correctly set', () {
      const title = 'Title';
      final content = Container();
      final buttonTexts = [
        'Ok',
      ];

      final request = CustomDialogRequest(
        title: title,
        content: content,
        buttonTexts: buttonTexts,
      );

      expect(request.title, title);
      expect(request.content, content);
      expect(request.buttonTexts, buttonTexts);
      expect(request.isModal, isFalse);
    });

    test('Empty buttonTexts throws assertion', () {
      expect(
        () => CustomDialogRequest(
          title: 'Title',
          content: Container(),
          buttonTexts: [],
        ),
        throwsAssertionError,
      );
    });
  });
}
