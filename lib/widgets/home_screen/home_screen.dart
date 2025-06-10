import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/home_screen/flags_tab/flags_tab.dart';
import 'package:bratacha/widgets/home_screen/home_tab/home_tab.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'HomeScreen';

  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;
  final _tabs = const [
    HomeTab(),
    FlagsTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      child: Scaffold(
        body: _tabs[_currentIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            unselectedItemColor: Theme.of(context).disabledColor,
            elevation: 16.0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  _currentIndex == 0 ? Icons.home : Icons.home_outlined,
                ),
                label: context.l10n.homeTabLabelText,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  _currentIndex == 1 ? MdiIcons.flagVariant : MdiIcons.flagVariantOutline,
                ),
                label: context.l10n.flagsTabLabelText,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  _currentIndex == 2 ? Icons.settings : Icons.settings_outlined,
                ),
                label: context.l10n.settingsTabLabelText,
              ),
            ],
            currentIndex: _currentIndex,
            onTap: (newIndex) => setState(() {
              _currentIndex = newIndex;
            }),
          ),
        ),
      ),
    );
  }
}
