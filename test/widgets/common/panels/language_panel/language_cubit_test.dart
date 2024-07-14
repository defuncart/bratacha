import 'package:bloc_test/bloc_test.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  group('$LanguageCubit', () {
    late MockPlayerDataService mockPlayerDataService;

    setUp(() {
      mockPlayerDataService = MockPlayerDataService();
    });

    blocTest<LanguageCubit, String>(
      'emits [] when nothing is added',
      setUp: () => when(() => mockPlayerDataService.language).thenReturn('en'),
      build: () => LanguageCubit(mockPlayerDataService),
      expect: () => [],
    );

    blocTest<LanguageCubit, String>(
      'emits [] when language is already set',
      setUp: () => when(() => mockPlayerDataService.language).thenReturn('en'),
      build: () => LanguageCubit(mockPlayerDataService),
      act: (cubit) => cubit.setLanguage('en'),
      expect: () => [],
    );

    blocTest<LanguageCubit, String>(
      'emits [en] when en is not already set',
      setUp: () => when(() => mockPlayerDataService.language).thenReturn('ga'),
      build: () => LanguageCubit(mockPlayerDataService),
      act: (cubit) => cubit.setLanguage('en'),
      expect: () => ['en'],
    );

    blocTest<LanguageCubit, String>(
      'emits [en, ga] when en and then ga are set',
      setUp: () => when(() => mockPlayerDataService.language).thenReturn('ga'),
      build: () => LanguageCubit(mockPlayerDataService),
      act: (cubit) => cubit
        ..setLanguage('en')
        ..setLanguage('ga'),
      expect: () => ['en', 'ga'],
    );
  });
}
