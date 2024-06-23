import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UrlLaucherService implements IUrlLaucherService {
  @override
  Future<void> openUrl(String url) async {
    // if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
    // }
  }
}
