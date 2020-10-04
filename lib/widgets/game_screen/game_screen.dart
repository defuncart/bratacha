import 'dart:async';

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
                    SizedBox(height: 16.0),
                    Expanded(
                      child: Center(
                        child: Text(
                          _gameService.questionCountry,
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    LayoutBuilder(
                      builder: (_, constraints) {
                        final size = (constraints.maxWidth - 16.0 - 16.0 - 16.0) / 2;

                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Wrap(
                            spacing: 16.0,
                            runSpacing: 16.0,
                            children: [
                              for (final id in _gameService.answerCountries)
                                GestureDetector(
                                  child: Flag(
                                    id,
                                    width: size,
                                    height: size,
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
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
