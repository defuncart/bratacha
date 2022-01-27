import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:bratacha/widgets/onboarding_screen/onboarding_page1.dart';
import 'package:bratacha/widgets/onboarding_screen/onboarding_page2.dart';
import 'package:bratacha/widgets/onboarding_screen/onboarding_page3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = 'OnboardingScreen';

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pages = [
    OnboardingPage1(),
    OnboardingPage2(),
    OnboardingPage3(),
  ];
  var _index = 0;

  bool get _isLastPage => _index == _pages.length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: _pages[_index],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Theme.of(context).colorScheme.secondary,
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size(
                      MediaQuery.of(context).size.width * 0.5,
                      40,
                    ),
                  ),
                ),
                child: Text(
                  AppLocalizations.generalContinue,
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 20,
                  ),
                ),
                onPressed: _isLastPage
                    ? () {
                        context.read<ISettingsDatabase>().hasSeenOnboarding = true;
                        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                      }
                    : () => setState(() => _index++),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
