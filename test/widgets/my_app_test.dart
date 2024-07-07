import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:bratacha/widgets/my_app.dart';
import 'package:bratacha/widgets/onboarding_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

void main() {
  group('$MyApp', () {
    late MockPlayerDataService mockPlayerDataService;
    late MockSettingsDatabase mockSettingsDatabase;

    setUp(() {
      mockPlayerDataService = MockPlayerDataService();
      mockSettingsDatabase = MockSettingsDatabase();

      when(() => mockPlayerDataService.language).thenReturn('en');
      when(() => mockPlayerDataService.hasCorrectlyAnswered(id: any(named: 'id'))).thenReturn(false);
    });

    testWidgets('Ensure widget tree is correct', (tester) async {
      when(() => mockSettingsDatabase.hasSeenOnboarding).thenReturn(true);

      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<IPlayerDataService>.value(
              value: mockPlayerDataService,
            ),
            RepositoryProvider<ISettingsDatabase>.value(
              value: mockSettingsDatabase,
            ),
          ],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MultiRepositoryProvider), findsNWidgets(2));
      expect(find.byType(MultiBlocProvider), findsOneWidget);
      expect(find.byType(MyApp), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Ensure home screen is displayed when user has seen onboarding', (tester) async {
      when(() => mockSettingsDatabase.hasSeenOnboarding).thenReturn(true);

      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<IPlayerDataService>.value(
              value: mockPlayerDataService,
            ),
            RepositoryProvider<ISettingsDatabase>.value(
              value: mockSettingsDatabase,
            ),
          ],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Ensure onboarding screen is displayed when user has not seen onboarding', (tester) async {
      when(() => mockSettingsDatabase.hasSeenOnboarding).thenReturn(false);

      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<IPlayerDataService>.value(
              value: mockPlayerDataService,
            ),
            RepositoryProvider<ISettingsDatabase>.value(
              value: mockSettingsDatabase,
            ),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(OnboardingScreen), findsOneWidget);
    });
  });
}
