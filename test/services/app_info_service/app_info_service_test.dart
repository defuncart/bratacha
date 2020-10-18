import 'package:bratacha/services/app_info_service/app_info_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppInfoService', () async {
    final appInfoService = AppInfoService();

    expect(appInfoService.applicationName, isNotNull);
    expect(appInfoService.applicationVersion, isNotNull);
    expect(appInfoService.applicationIcon, isNotNull);
    expect(appInfoService.applicationLegalese, isNotNull);
  });
}
