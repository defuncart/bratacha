import 'package:bratacha/intl/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class IntlHelper {
  static void ensureDelegatesLoaded() async {
    await GlobalMaterialLocalizations.delegate.load(AppLocalizationsDelegate.supportedLocals.first);
    await GlobalWidgetsLocalizations.delegate.load(AppLocalizationsDelegate.supportedLocals.first);
    await GlobalCupertinoLocalizations.delegate.load(AppLocalizationsDelegate.supportedLocals.first);
  }
}
