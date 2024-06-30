import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:bratacha/widgets/my_app.dart';
import 'package:bratacha/widgets/onboarding_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$MyApp', () {
    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<IPlayerDataService>(
              create: (_) => _MockPlayerDataService(),
            ),
            RepositoryProvider<ISettingsDatabase>(
              create: (_) => _MockSettingsDatabase(),
            ),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(MultiRepositoryProvider), findsNWidgets(2));
      expect(find.byType(MultiBlocProvider), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
    }, skip: true);

    testWidgets('Ensure home screen is displayed when user has seen onboarding', (tester) async {
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<IPlayerDataService>(
              create: (_) => _MockPlayerDataService(),
            ),
            RepositoryProvider<ISettingsDatabase>(
              create: (_) => _MockSettingsDatabase(hasSeenOnboarding: true),
            ),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    }, skip: true);

    testWidgets('Ensure onboarding screen is displayed when user has not seen onboarding', (tester) async {
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<IPlayerDataService>(
              create: (_) => _MockPlayerDataService(),
            ),
            RepositoryProvider<ISettingsDatabase>(
              create: (_) => _MockSettingsDatabase(hasSeenOnboarding: false),
            ),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(OnboardingScreen), findsOneWidget);
    }, skip: true);
  });
}

class _MockPlayerDataService extends Mock implements IPlayerDataService {
  @override
  String get language => 'en';

  @override
  bool hasCorrectlyAnswered({required String id}) => true;
}

class _MockSettingsDatabase extends Mock implements ISettingsDatabase {
  final bool _hasSeenOnboarding;

  _MockSettingsDatabase({bool hasSeenOnboarding = true}) : _hasSeenOnboarding = hasSeenOnboarding;

  @override
  bool get hasSeenOnboarding => _hasSeenOnboarding;
}
