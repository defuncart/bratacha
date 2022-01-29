import 'package:bloc_test/bloc_test.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$LanguageCubit', () {
    blocTest<LanguageCubit, String>(
      'emits [] when nothing is added',
      build: () => LanguageCubit(_MockPlayerDataService()),
      expect: () => [],
    );

    blocTest<LanguageCubit, String>(
      'emits [en] when en is set',
      build: () => LanguageCubit(_MockPlayerDataService(language: 'en')),
      act: (cubit) => cubit.setLanguage('en'),
      expect: () => ['en'],
    );

    blocTest<LanguageCubit, String>(
      'emits [en, ga] when en and then ga are set',
      build: () => LanguageCubit(_MockPlayerDataService(language: 'en')),
      act: (cubit) => cubit
        ..setLanguage('en')
        ..setLanguage('ga'),
      expect: () => ['en', 'ga'],
    );
  });
}

class _MockPlayerDataService extends Mock implements IPlayerDataService {
  String _langauge;

  _MockPlayerDataService({String language = 'en'}) : _langauge = language;

  @override
  String get language => _langauge;

  @override
  set language(String value) => _langauge = value;
}
