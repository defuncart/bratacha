import 'package:bratacha/services/app_info_service/app_info_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  group('AppInfoService', () {
    late AppInfoService service;

    setUp(() {
      service = AppInfoService();
      PackageInfo.setMockInitialValues(
        appName: 'Bratacha',
        packageName: '',
        version: '1.2.3',
        buildNumber: '4',
        buildSignature: '',
      );
    });

    test('applicationName', () async {
      await service.init();

      expect(service.applicationName, 'Bratacha');
    });

    test('applicationVersion', () async {
      await service.init();

      expect(service.applicationVersion, '1.2.3 (4)');
    });

    test('applicationLegalese', () {
      expect(service.applicationLegalese, '© 2024 defuncart');
    });
  });
}
