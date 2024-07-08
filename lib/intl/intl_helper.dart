import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class IntlHelper {
  static void ensureDelegatesLoaded() async {
    await GlobalMaterialLocalizations.delegate.load(AppLocalizations.supportedLocales.first);
    await GlobalWidgetsLocalizations.delegate.load(AppLocalizations.supportedLocales.first);
    await GlobalCupertinoLocalizations.delegate.load(AppLocalizations.supportedLocales.first);
  }
}
