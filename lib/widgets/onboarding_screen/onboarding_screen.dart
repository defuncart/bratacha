import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = 'OnboardingScreen';

  const OnboardingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor),
          ),
          child: Icon(
            Icons.arrow_forward_sharp,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          onPressed: () {
            context.repository<ISettingsDatabase>().hasSeenOnboarding = true;
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          },
        ),
      ),
    );
  }
}
