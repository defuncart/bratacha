// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_final_fields, public_member_api_docs, prefer_single_quotes, omit_local_variable_types, unnecessary_this

import 'dart:async';

import 'package:flutter/material.dart';

/// A  class generated by flappy_translator package containing localized strings
class AppLocalizations {
  static String get test => _getText('test');

  static Map<String, String> _localizedValues;

  static Map<String, String> _enValues = {
    'test': 'Hello World!',
  };

  static Map<String, String> _byValues = {
    'test': 'Здароўствуй свет!',
  };

  static Map<String, String> _cyValues = {
    'test': 'Helo Byd!',
  };

  static Map<String, String> _gaValues = {
    'test': 'Dia duit domhan!',
  };

  static Map<String, Map<String, String>> _allValues = {
    'en': _enValues,
    'by': _byValues,
    'cy': _cyValues,
    'ga': _gaValues,
  };

  AppLocalizations(Locale locale) {
    _locale = locale;
    _localizedValues = null;
  }

  static Locale _locale;

  static String _getText(String key) {
    return _localizedValues[key] ?? '** $key not found';
  }

  static Locale get currentLocale => _locale;

  static String get currentLanguage => _locale.languageCode;

  static Future<AppLocalizations> load(Locale locale) async {
    final translations = AppLocalizations(locale);
    _localizedValues = _allValues[locale.toString()];
    return translations;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  static final Set<Locale> supportedLocals = {
    Locale('en'),
    Locale('by'),
    Locale('cy'),
    Locale('ga'),
  };

  @override
  bool isSupported(Locale locale) => supportedLocals.contains(locale);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
