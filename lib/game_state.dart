class PegState {
  final int idx; // index of the hole that is occupied by the peg;
  final bool isMovable; // can it be moved to somewhere?

  PegState({this.idx, this.isMovable = false});

  PegState.clone(PegState ps, {int idx, bool isMovable})
      : this(idx: idx ?? ps.idx, isMovable: isMovable ?? ps.isMovable);
}

class GameState {
  final int selectedPeg; // index of the hole that is occupied by the selected peg;
  final List<int> holesToGo; // indexes of the holes that can be moved to by selected peg;
  final bool isGameFinished;
  final List<PegState> pegStates; // hole indexes of remaining pegs and their movability;

  const GameState({
    this.selectedPeg = -1,
    this.holesToGo = const [],
    this.isGameFinished = false,
    this.pegStates,
  });

  GameState.clone(
    GameState gs, {
    int selectedPeg,
    List<int> holesToGo,
    bool isGameFinished,
    List<PegState> pegStates,
  }) : this(
          selectedPeg: selectedPeg ?? gs.selectedPeg,
          holesToGo: holesToGo ?? List<int>.from(gs.holesToGo, growable: false),
          isGameFinished: isGameFinished ?? gs.isGameFinished,
          pegStates: pegStates ??
              gs.pegStates.map((ps) => PegState.clone(ps)).toList(),
        );
}
