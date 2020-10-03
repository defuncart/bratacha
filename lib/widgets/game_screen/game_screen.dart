import 'dart:async';

import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreenArguments {
  final int level;

  const GameScreenArguments({@required this.level});
}

class GameScreen extends StatefulWidget {
  static const routeName = 'GameScreen';

  const GameScreen({Key key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var _isLoading = true;
  List<Country> _countries;
  int _index;

  Country get _currentCountry => _countries[_index];

  @override
  void initState() {
    super.initState();

    _index = 0;
    scheduleMicrotask(() {
      final args = ModalRoute.of(context).settings.arguments as GameScreenArguments;
      final level = args.level;
      _countries = context.repository<LevelManager>().countriesForLevel(level);
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? Container()
          : SafeArea(
              child: Column(
                children: [
                  Text(_currentCountry.localizedName),
                ],
              ),
            ),
    );
  }
}
