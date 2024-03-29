import 'dart:ui';

import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CountryExtensions', () {
    test('localizedName', () async {
      CountryLocalizations.load(const Locale('en'));

      final country = CountryService.countries.firstWhere((country) => country.id == 'de');
      expect(country.localizedName, 'Germany');

      CountryLocalizations.load(const Locale('ga'));

      expect(country.localizedName, 'An Ghearmáin');
    });
  });
}
