import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

class _GaCupertinoLocalizationsDelegate extends LocalizationsDelegate<GaCupertinoLocalizations> {
  const _GaCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ga';

  static final Map<Locale, Future<GaCupertinoLocalizations>> _loadedTranslations =
      <Locale, Future<GaCupertinoLocalizations>>{};

  @override
  Future<GaCupertinoLocalizations> load(Locale locale) {
    assert(isSupported(locale));
    return _loadedTranslations.putIfAbsent(locale, () {
      // util.loadDateIntlDataIfNotLoaded();

      final String localeName = intl.Intl.canonicalizedLocale(locale.toString());
      assert(
        locale.toString() == localeName,
        'Flutter does not support the non-standard locale form $locale (which '
        'might be $localeName',
      );

      late intl.DateFormat fullYearFormat;
      late intl.DateFormat dayFormat;
      late intl.DateFormat mediumDateFormat;
      // We don't want any additional decoration here. The am/pm is handled in
      // the date picker. We just want an hour number localized.
      late intl.DateFormat singleDigitHourFormat;
      late intl.DateFormat singleDigitMinuteFormat;
      late intl.DateFormat doubleDigitMinuteFormat;
      late intl.DateFormat singleDigitSecondFormat;
      late intl.NumberFormat decimalFormat;

      void loadFormats(String? locale) {
        fullYearFormat = intl.DateFormat.y(locale);
        dayFormat = intl.DateFormat.d(locale);
        mediumDateFormat = intl.DateFormat.MMMEd(locale);
        // TODO(xster): fix when https://github.com/dart-lang/intl/issues/207 is resolved.
        singleDigitHourFormat = intl.DateFormat('HH', locale);
        singleDigitMinuteFormat = intl.DateFormat.m(locale);
        doubleDigitMinuteFormat = intl.DateFormat('mm', locale);
        singleDigitSecondFormat = intl.DateFormat.s(locale);
        decimalFormat = intl.NumberFormat.decimalPattern(locale);
      }

      if (intl.DateFormat.localeExists(localeName)) {
        loadFormats(localeName);
      } else if (intl.DateFormat.localeExists(locale.languageCode)) {
        loadFormats(locale.languageCode);
      } else {
        loadFormats(null);
      }

      return SynchronousFuture<GaCupertinoLocalizations>(
        GaCupertinoLocalizations(
          fullYearFormat: fullYearFormat,
          dayFormat: dayFormat,
          mediumDateFormat: mediumDateFormat,
          singleDigitHourFormat: singleDigitHourFormat,
          singleDigitMinuteFormat: singleDigitMinuteFormat,
          doubleDigitMinuteFormat: doubleDigitMinuteFormat,
          singleDigitSecondFormat: singleDigitSecondFormat,
          decimalFormat: decimalFormat,
        ),
      );
    });
  }

  @override
  bool shouldReload(_GaCupertinoLocalizationsDelegate old) => false;

  @override
  String toString() => 'GlobalCupertinoLocalizations.delegate(${kCupertinoSupportedLanguages.length} locales)';
}

class GaCupertinoLocalizations extends GlobalCupertinoLocalizations {
  const GaCupertinoLocalizations({
    super.localeName = 'ga',
    required super.fullYearFormat,
    required super.dayFormat,
    required super.mediumDateFormat,
    required super.singleDigitHourFormat,
    required super.singleDigitMinuteFormat,
    required super.doubleDigitMinuteFormat,
    required super.singleDigitSecondFormat,
    required super.decimalFormat,
  });

  static const LocalizationsDelegate<CupertinoLocalizations> delegate = _GaCupertinoLocalizationsDelegate();

  @override
  String get alertDialogLabel => throw UnimplementedError();

  @override
  String get anteMeridiemAbbreviation => throw UnimplementedError();

  @override
  String get clearButtonLabel => throw UnimplementedError();

  @override
  String get copyButtonLabel => throw UnimplementedError();

  @override
  String get cutButtonLabel => throw UnimplementedError();

  @override
  String get datePickerDateOrderString => throw UnimplementedError();

  @override
  String get datePickerDateTimeOrderString => throw UnimplementedError();

  @override
  String? get datePickerHourSemanticsLabelFew => null;

  @override
  String? get datePickerHourSemanticsLabelMany => null;

  @override
  String? get datePickerHourSemanticsLabelOne => throw UnimplementedError();

  @override
  String get datePickerHourSemanticsLabelOther => throw UnimplementedError();

  @override
  String? get datePickerHourSemanticsLabelTwo => null;

  @override
  String? get datePickerHourSemanticsLabelZero => null;

  @override
  String? get datePickerMinuteSemanticsLabelFew => null;

  @override
  String? get datePickerMinuteSemanticsLabelMany => null;

  @override
  String? get datePickerMinuteSemanticsLabelOne => throw UnimplementedError();

  @override
  String get datePickerMinuteSemanticsLabelOther => throw UnimplementedError();

  @override
  String? get datePickerMinuteSemanticsLabelTwo => null;

  @override
  String? get datePickerMinuteSemanticsLabelZero => null;

  @override
  String get lookUpButtonLabel => throw UnimplementedError();

  @override
  String get menuDismissLabel => throw UnimplementedError();

  @override
  String get modalBarrierDismissLabel => throw UnimplementedError();

  @override
  String get noSpellCheckReplacementsLabel => throw UnimplementedError();

  @override
  String get pasteButtonLabel => throw UnimplementedError();

  @override
  String get postMeridiemAbbreviation => throw UnimplementedError();

  @override
  String get searchTextFieldPlaceholderLabel => throw UnimplementedError();

  @override
  String get searchWebButtonLabel => throw UnimplementedError();

  @override
  String get selectAllButtonLabel => throw UnimplementedError();

  @override
  String get shareButtonLabel => throw UnimplementedError();

  @override
  String get tabSemanticsLabelRaw => throw UnimplementedError();

  @override
  String? get timerPickerHourLabelFew => null;

  @override
  String? get timerPickerHourLabelMany => null;

  @override
  String? get timerPickerHourLabelOne => throw UnimplementedError();

  @override
  String get timerPickerHourLabelOther => throw UnimplementedError();

  @override
  String? get timerPickerHourLabelTwo => null;

  @override
  String? get timerPickerHourLabelZero => null;

  @override
  String? get timerPickerMinuteLabelFew => null;

  @override
  String? get timerPickerMinuteLabelMany => null;

  @override
  String? get timerPickerMinuteLabelOne => throw UnimplementedError();

  @override
  String get timerPickerMinuteLabelOther => throw UnimplementedError();

  @override
  String? get timerPickerMinuteLabelTwo => null;

  @override
  String? get timerPickerMinuteLabelZero => null;

  @override
  String? get timerPickerSecondLabelFew => null;

  @override
  String? get timerPickerSecondLabelMany => null;

  @override
  String? get timerPickerSecondLabelOne => throw UnimplementedError();

  @override
  String get timerPickerSecondLabelOther => throw UnimplementedError();

  @override
  String? get timerPickerSecondLabelTwo => null;

  @override
  String? get timerPickerSecondLabelZero => null;

  @override
  String get todayLabel => throw UnimplementedError();
}
