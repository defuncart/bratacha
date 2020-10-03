import 'dart:async';

import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/services/game_service.dart';
import 'package:bratacha/widgets/common/flag.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _isLoading = true;
  GameService _gameService;

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      final args = ModalRoute.of(context).settings.arguments as GameScreenArguments;
      final level = args.level;
      _gameService = GameService(level: level, levelManager: context.repository<LevelManager>());
      _gameService.initialize();
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: _isLoading
          ? Container()
          : SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      _gameService.questionCountry.localizedName,
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: 16.0,
                        runSpacing: 16.0,
                        children: [
                          for (final id in _gameService.answerCountries)
                            GestureDetector(
                              child: Flag(
                                id,
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.width * 0.4,
                              ),
                              onTap: () {
                                final correct = _gameService.answerWithId(id);
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Icon(correct ? Icons.check : Icons.close),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                                if (_gameService.levelCompleted) {
                                  Navigator.of(context).pop();
                                } else {
                                  setState(() {});
                                }
                              },
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
