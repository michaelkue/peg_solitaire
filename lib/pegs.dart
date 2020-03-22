import 'package:flutter/material.dart';
import 'package:peg_solitaire/hole-config.dart';
import 'package:peg_solitaire/game_state.dart';
import 'package:peg_solitaire/peg.dart';

/// draw the list of remaining pegs onto their holes,
/// dependent on game state and config;
class Pegs extends StatelessWidget {
  Pegs(
      {Key key,
      this.size,
        this.gameState,
        this.holesConfig,
      this.onTap})
      : super(key: key);

  final double size;
  final GameState gameState;
  final List<HoleConfig> holesConfig;
  final Function(int idx) onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _getPegs(this.size, this.gameState),
    );
  }

  List<Align> _getPegs(
          double size, GameState state) =>
          state.pegStates.map(
          (pegState) => Align(
                alignment: FractionalOffset(
                    holesConfig[pegState.idx].point.x,
                    holesConfig[pegState.idx].point.y),
                child: _getPeg(pegState, state.selectedPeg == pegState.idx),
              )).toList();

  Peg _getPeg(final PegState pegState, final bool isSelected) {
    return Peg(
        idx: pegState.idx,
        size: size,
        isMovable: pegState.isMovable,
        isSelected: isSelected,
        onTap: _onTap);
  }

  void _onTap(int idx) {
    onTap(idx);
  }
}
