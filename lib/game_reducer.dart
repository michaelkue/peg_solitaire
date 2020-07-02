import 'package:peg_solitaire/hole-config.dart';
import 'package:peg_solitaire/game_state.dart';

class GameReducer {
  List<HoleConfig> _holesConfig;
  GameState gameState;

  GameReducer(this._holesConfig) {}

  /// - sets the pegs to their initial positions,
  ///   according to config;
  /// - derive the PegState list;
  /// - put game state together;
  GameState initGameState() {
    final List<int> _pegs = _holesConfig
        .where((config) => config.hasInitialPeg)
        .map((config) => config.idx)
        .toList();

    final List<PegState> _pegStates = _initPegStates(_pegs);

    var state = GameState(
      pegStates: _pegStates,
    );
    this.gameState = state;
    return state;
  }

  /// derives new game state from user action (tap peg):
  /// - set the selected peg
  /// - finds the holes to go from this peg;
  onTapPeg(int idx) {
    PegState tappedPeg =
        this.gameState.pegStates.firstWhere((s) => s.idx == idx);

    if (tappedPeg.isMovable) {
      this.gameState = GameState.clone(
        this.gameState,
        holesToGo: _getHolesToGo(
            this.gameState.pegStates.map((s) => s.idx).toList(), idx),
        selectedPeg: idx,
      );
    }
    return this.gameState;
  }

  /// starts peg move
  onTapHole(int idx) {
    if (this.gameState.holesToGo.contains(idx)) {
      var pegStates = List<PegState>.from(this.gameState.pegStates);
      pegStates.removeWhere((s) => s.idx == this.gameState.selectedPeg);
      this.gameState = GameState(
        pegStates: pegStates.map((s) => PegState(idx: s.idx)).toList(),
        movingPegState: MovingPegState(
          isActive: true,
          idxStart: this.gameState.selectedPeg,
          idxEnd: idx,
        ),
      );
    }
    return this.gameState;
  }

  /// derives new game state from user action (tap hole)
  /// - removes selected peg and jumped peg;
  /// - puts peg onto the target hole;
  /// - remove selected peg and holes  to o from game state;
  onFinishMove() {
    // finally place the moved peg onto its new hole
    var pegStates = List<PegState>.from(this.gameState.pegStates);
    pegStates.add(PegState(
      idx: this.gameState.movingPegState.idxEnd,
    ));
    // after move, remove the jumped peg
    var idxRemove = _getJumpedHole(
        this.gameState.movingPegState.idxStart, this.gameState.movingPegState.idxEnd);
    pegStates.removeWhere((s) => s.idx == idxRemove);
    this.gameState = GameState(
      pegStates: pegStates,
      movingPegState: MovingPegState(),
      removingPegState: RemovingPegState(
        isActive: true,
        idxRemove: idxRemove,
      ),
    );
    return this.gameState;
  }

  onFinishRemove() {
//    var pegStates = _proceedPegStates(oldPegStates: this.gameState.pegStates);
    var newPegStates = _initPegStates(this.gameState.pegStates.map((s) => s.idx).toList());
    this.gameState = GameState(
      pegStates: newPegStates,
      isGameFinished: newPegStates.where((state) => state.isMovable).isEmpty,
    );
    return this.gameState;
  }

  /// derives list of PegState from peg indexes;
  List<PegState> _initPegStates(final List<int> _pegs) {
    List<PegState> pegStates = _pegs
        .map((_peg) => PegState(idx: _peg, isMovable: _canMovePeg(_pegs, _peg)))
        .toList();
    return pegStates;
  }

  /// returns the list of holes, that a peg can reach);
  List<int> _getHolesToGo(List<int> _pegs, int idxFrom) {
    return _holesConfig[idxFrom]
        .holesToGo
        .where((f) => !_pegs.contains(f.idx))
        .where((f) => _pegs.contains(f.idxJumped))
        .map((f) => f.idx)
        .toList();
  }

  /// returns the hole that is jumped during a peg movement from idxFrom to idxTo;
  int _getJumpedHole(int idxFrom, int idxTo) {
    return _holesConfig[idxFrom]
        .holesToGo
        .where((f) => f.idx == idxTo)
        .map((f) => f.idxJumped)
        .toList()[0];
  }

  /// checks if a given peg can be moved;
  bool _canMovePeg(List<int> _pegs, int idx) {
    return _getHolesToGo(_pegs, idx).length > 0;
  }
}
