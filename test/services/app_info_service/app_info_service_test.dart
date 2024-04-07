import 'package:bratacha/services/app_info_service/app_info_service.dart';
import 'package:flutter/material.dart' show Image;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppInfoService', () {
    final appInfoService = AppInfoService();

    test('applicationName', () {
      expect(appInfoService.applicationName, isA<String>());
      expect(appInfoService.applicationName, 'Bratacha');
    });

    test('applicationVersion', () {
      expect(appInfoService.applicationVersion, isA<String>());
      expect(appInfoService.applicationVersion, '0.0.1');
    });

    test('applicationIcon', () {
      expect(appInfoService.applicationIcon, isA<Image>());
    });

    test('applicationLegalese', () {
      expect(appInfoService.applicationLegalese, isA<String>());
      expect(appInfoService.applicationLegalese, '© 2024 defuncart');
    });
  });
}
