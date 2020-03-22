import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:peg_solitaire/board.dart';
import 'package:peg_solitaire/finished-dialog.dart';
import 'package:peg_solitaire/hole-config.dart';
import 'package:peg_solitaire/game_reducer.dart';
import 'package:peg_solitaire/game_state.dart';
import 'package:peg_solitaire/pegs.dart';

class BoardSetting extends StatefulWidget {
  BoardSetting({Key key, this.title}) : super(key: key);

  final String title;

  @override
  BoardSettingState createState() => new BoardSettingState();
}

class BoardSettingState extends State<BoardSetting> {
  GameReducer _gameReducer;
  GameState _gameState;
  List<HoleConfig> _holesConfig = getHolesConfig();

  @override
  void initState() {
    super.initState();
    this._gameReducer = GameReducer(_holesConfig);
    this._initGame();
  }

  /// reset the pegs to a new game
  void _initGame() {
    this._gameState = this._gameReducer.initGameState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final width = MediaQuery.of(context).size.width;
    final boardSize = width - 10;
    final posSize = boardSize / 6;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(50),
            child: Text(
              _gameState.holesToGo.length > 0
                  ? "Please tap a highlighted hole"
                  : "Please tap a highlighted peg",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Card(
            elevation: 10,
            color: Colors.lime[100],
            child: Container(
              padding: EdgeInsets.all(30),
              height: boardSize,
              width: boardSize,
              child: Stack(
                children: _buildBoard(posSize),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// places the holes according to config,
  /// places pegs on the holes, according to config and game state;
  List<Widget> _buildBoard(double posSize) {
    List<Widget> board = [
      Board(
          holesConfig: _holesConfig,
          size: posSize,
          holesMarked: _gameState.holesToGo,
          onTap: _onTapHole),
      Pegs(
        size: posSize,
        gameState: _gameState,
        holesConfig: _holesConfig,
        onTap: _onTapPeg,
      ),
    ];
    return board;
  }

  /// passes user action (tap a peg) to the reducer
  void _onTapPeg(int idx) {
    setState(() {
      _gameState = _gameReducer.onTapPeg(idx);
    });
  }

  /// passes user action (tap a hole) to the reducer;
  /// if the new state means the games is finished, the replay
  /// dialog is shown;
  void _onTapHole(int idx) {
    setState(() {
      _gameState = _gameReducer.onTapHole(idx);
    });
    if (_gameState.isGameFinished) {
      FinishedDialog(
          context: this.context,
          onRepeat: () {
            setState(() {
              _initGame();
              Navigator.of(context).pop();
            });
          })
        ..show();
    }
  }
}
