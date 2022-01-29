import 'package:bratacha/services/url_launcher_service/url_launcher_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$UrlLaucherService', () {
    final urlLaucherService = UrlLaucherService();

    testWidgets('UrlLaucherService', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();

      // ignore: unawaited_futures
      urlLaucherService.openUrl('test');
    });
  });
}
