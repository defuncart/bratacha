import 'dart:ui';

import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('localizedName', () async {
    await CountryLocalizations.load(Locale('en'));

    final country = CountryService.countries.firstWhere((country) => country.id == 'de', orElse: () => null);
    expect(country.localizedName, 'Germany');

    await CountryLocalizations.load(Locale('ga'));

    expect(country.localizedName, 'An Ghearmáin');
  });
}
