import 'dart:async';

import 'package:flutter/material.dart';

part 'country_localizations.g.dart';

/// A class of localizations for countries (inspired by flappy_translator)
class CountryLocalizations with _$CountryLocalizations {
  static Map<String, String> _currentLocale;

  static Map<String, Map<String, String>> get _locales => _$CountryLocalizations._locales;

  CountryLocalizations(Locale locale) {
    _currentLocale = null;
  }

  static String getString(String key) => _currentLocale[key] ?? '** $key not found';

  static Future<CountryLocalizations> load(Locale locale) async {
    final translations = CountryLocalizations(locale);
    _currentLocale = _locales[locale.toString()];
    return translations;
  }
}

class CountryLocalizationsDelegate extends LocalizationsDelegate<CountryLocalizations> {
  const CountryLocalizationsDelegate();

  static Set<Locale> get supportedLocales => _$CountryLocalizationsDelegate._supportedLocales;

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale);

  @override
  Future<CountryLocalizations> load(Locale locale) => CountryLocalizations.load(locale);

  @override
  bool shouldReload(CountryLocalizationsDelegate old) => false;
}
