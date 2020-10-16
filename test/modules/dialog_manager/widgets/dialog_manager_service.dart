import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dialogService null value triggers assertion', () {
    expect(
      () => DialogManager(
        dialogService: null,
        child: Container(),
      ),
      throwsAssertionError,
    );
  });

  test('child null value triggers assertion', () {
    expect(
      () => DialogManager(
        dialogService: DialogService(),
        child: null,
      ),
      throwsAssertionError,
    );
  });
}
