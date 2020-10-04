import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/home_screen/home_tab/home_tab.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/settings_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;
  final _tabs = [
    HomeTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Theme.of(context).appBarTheme.color),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Theme.of(context).disabledColor,
          elevation: 16.0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: AppLocalizations.homeTabLabelText,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: AppLocalizations.settingsTabLabelText,
            )
          ],
          currentIndex: _currentIndex,
          onTap: (newIndex) => setState(() {
            _currentIndex = newIndex;
          }),
        ),
      ),
    );
  }
}
