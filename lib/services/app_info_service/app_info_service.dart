import 'package:bratacha/services/app_info_service/i_app_info_service.dart';
import 'package:flutter/widgets.dart';

class AppInfoService implements IAppInfoService {
  @override
  String get applicationName => 'Bratacha';

  @override
  String get applicationVersion => '0.0.1'; //TODO use getVersion

  @override
  Widget get applicationIcon => Image.asset('assets/settings/app_icon.png');

  @override
  String get applicationLegalese => '© 2024 defuncart';
}
