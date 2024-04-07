// ignore_for_file: depend_on_referenced_packages

import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

extension TestWindowExtensions on TestWindow {
  /// Simulates a given size in a widget test
  void simulateSize(Size size) {
    physicalSizeTestValue = size;
    devicePixelRatioTestValue = 1.0;
    addTearDown(
      () => [
        clearPhysicalSizeTestValue,
        clearDevicePixelRatioTestValue,
      ],
    );
  }
}
