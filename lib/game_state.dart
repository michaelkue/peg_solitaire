class PegState {
  final int idx; // index of the hole that is occupied by the peg;
  final bool isMovable; // can it be moved to somewhere?

  PegState({this.idx, this.isMovable = false});

  PegState.clone(PegState ps, {int idx, bool isMovable})
      : this(idx: idx ?? ps.idx, isMovable: isMovable ?? ps.isMovable);
}

class MovingPegState {
  final bool isActive;
  final int idxStart;
  final int idxEnd;

  const MovingPegState({this.isActive = false, this.idxStart = -1, this.idxEnd = -1});

  MovingPegState.clone(MovingPegState mps,
      {bool isActive, int idxStart, int idxEnd})
      : this(
            isActive: isActive ?? mps.isActive,
            idxStart: idxStart ?? mps.idxStart,
            idxEnd: idxEnd ?? mps.idxEnd);
}

class RemovingPegState {
  final bool isActive;
  final int idxRemove;

  const RemovingPegState({this.isActive = false, this.idxRemove = -1});

  RemovingPegState.clone(RemovingPegState rps, {bool isActive, int idxRemove})
      : this(
            isActive: isActive ?? rps.isActive,
            idxRemove: idxRemove ?? rps.idxRemove);
}

class GameState {
  final int selectedPeg; // index of the hole that is occupied by the selected peg;
  final List<int> holesToGo; // indexes of the holes that can be moved to by selected peg;
  final bool isGameFinished;
  final List<PegState> pegStates; // hole indexes of remaining pegs and their movability;
  final MovingPegState movingPegState;
  final RemovingPegState removingPegState;

  const GameState(
      {this.selectedPeg = -1,
      this.holesToGo = const [],
      this.isGameFinished = false,
      this.pegStates,
      this.movingPegState = const MovingPegState(),
      this.removingPegState = const RemovingPegState()});

  GameState.clone(GameState gs,
      {int selectedPeg,
      List<int> holesToGo,
      bool isGameFinished,
      List<PegState> pegStates,
      MovingPegState movingPegState,
      RemovingPegState removingPegState})
      : this(
            selectedPeg: selectedPeg ?? gs.selectedPeg,
            holesToGo:
                holesToGo ?? List<int>.from(gs.holesToGo, growable: false),
            isGameFinished: isGameFinished ?? gs.isGameFinished,
            pegStates: pegStates ??
                gs.pegStates.map((ps) => PegState.clone(ps)).toList(),
            movingPegState:
                movingPegState ?? MovingPegState.clone(gs.movingPegState),
            removingPegState: removingPegState ??
                RemovingPegState.clone(gs.removingPegState));
}
