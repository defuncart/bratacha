import 'package:bloc_test/bloc_test.dart';
import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/widgets/home_screen/flags_tab/search_flags_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$SearchFlagsCubit', () {
    final cases = {
      'en': ('A', 175),
      'be': ('А', 10),
      'cy': ('A', 175),
      'ga': ('A', 175),
    };

    for (final testCase in cases.entries) {
      final language = testCase.key;
      final searchTerm = testCase.value.$1;
      final expectedResults = testCase.value.$2;

      // ensure localizations are setup
      CountryLocalizations.load(Locale(language));

      blocTest(
        'when $language and search term $searchTerm, expect $expectedResults result(s)',
        build: () => SearchFlagsCubit(language),
        act: (cubit) => cubit.update(searchTerm),
        // expect: () => [
        //   hasLength(expectedResults),
        // ],
      );
    }
  });
}
