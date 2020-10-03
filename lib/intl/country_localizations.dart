import 'dart:async';

import 'package:flutter/widgets.dart';

part 'country_localizations.g.dart';

/// A class of localizations for countries (inspired by flappy_translator)
class CountryLocalizations with _$CountryLocalizations {
  static Map<String, String> _currentLocale;

  static Map<String, Map<String, String>> get _locales => _$CountryLocalizations._locales;

  static String getString(String key) => _currentLocale[key] ?? '** $key not found';

  CountryLocalizations.load(Locale locale) {
    _currentLocale = _locales[locale.toString()];
  }
}

class CountryLocalizationsDelegate extends LocalizationsDelegate<CountryLocalizations> {
  const CountryLocalizationsDelegate();

  static Set<Locale> get supportedLocales => _$CountryLocalizationsDelegate._supportedLocales;

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale);

  @override
  Future<CountryLocalizations> load(Locale locale) async => CountryLocalizations.load(locale);

  @override
  bool shouldReload(CountryLocalizationsDelegate old) => false;
}
