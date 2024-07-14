import 'package:bratacha/services/app_info_service/i_app_info_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService implements IAppInfoService {
  late final String _applicationName;
  late final String _applicationVersion;

  Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();

    _applicationName = packageInfo.appName;
    _applicationVersion = '${packageInfo.version} (${packageInfo.buildNumber})';
  }

  @override
  String get applicationName => _applicationName;

  @override
  String get applicationVersion => _applicationVersion;

  @override
  String get applicationLegalese => '© 2024 defuncart';
}
