import 'package:bloc_test/bloc_test.dart';
import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/language_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('LanguageCubit', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => LanguageCubit(_MockSettingsDatabase()),
      expect: [],
    );

    blocTest(
      'emits [en] when en is set',
      build: () => LanguageCubit(_MockSettingsDatabase(language: 'en')),
      act: (cubit) => cubit.setLanguage('en'),
      expect: ['en'],
    );

    blocTest(
      'emits [en, ga] when en and then ga are set',
      build: () => LanguageCubit(_MockSettingsDatabase(language: 'en')),
      act: (cubit) => cubit..setLanguage('en')..setLanguage('ga'),
      expect: ['en', 'ga'],
    );
  });
}

class _MockSettingsDatabase extends Mock implements ISettingsDatabase {
  String _langauge;

  _MockSettingsDatabase({String language = 'en'}) : _langauge = language;

  @override
  String get language => _langauge;

  @override
  set language(String value) => _langauge = value;
}
