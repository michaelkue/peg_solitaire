import 'dart:math';

/// Describes a possible peg move; this is specific to each of the holes
/// on the board.
class HoleToGo {
  int idx; // unique index of the reachable hole
  int idxJumped; // index of the hole that has to be jumped on the way to idx

  HoleToGo({this.idx, this.idxJumped});
}

/// Configuration item for a single hole on the board.
class HoleConfig {
  int idx; // unique index
  Point<double> point; // geometrical position on the board
  List<HoleToGo> holesToGo; // holes, that can be reached by peg jumps from here
  bool hasInitialPeg; // whether the hole initially is occupied

  HoleConfig({this.idx, this.point, this.holesToGo, this.hasInitialPeg = true});
}

/// geometrical deltas, relative to the board size.
final dx = 0.125;
final dy = 0.25;

/// List of HoleConfig; describes the hole positions and possible peg moves;
List<HoleConfig> getHolesConfig() {
  return [
    //-----------------  line 0
    HoleConfig(idx: 0, point: Point(0 * dx, 0 * dy), holesToGo: [
      HoleToGo(idx: 2, idxJumped: 1),
      HoleToGo(idx: 9, idxJumped: 5)
    ]),
    HoleConfig(idx: 1, point: Point(2 * dx, 0 * dy), holesToGo: [
      HoleToGo(idx: 3, idxJumped: 2),
      HoleToGo(idx: 10, idxJumped: 6)
    ]),
    HoleConfig(idx: 2, point: Point(4 * dx, 0 * dy), holesToGo: [
      HoleToGo(idx: 0, idxJumped: 1),
      HoleToGo(idx: 4, idxJumped: 3),
      HoleToGo(idx: 9, idxJumped: 6),
      HoleToGo(idx: 11, idxJumped: 7),
    ]),
    HoleConfig(idx: 3, point: Point(6 * dx, 0 * dy), holesToGo: [
      HoleToGo(idx: 1, idxJumped: 2),
      HoleToGo(idx: 10, idxJumped: 7)
    ]),
    HoleConfig(idx: 4, point: Point(8 * dx, 0 * dy), holesToGo: [
      HoleToGo(idx: 2, idxJumped: 3),
      HoleToGo(idx: 11, idxJumped: 8)
    ]),
    //-----------------  line 1
    HoleConfig(idx: 5, point: Point(1 * dx, 1 * dy), holesToGo: [
      HoleToGo(idx: 7, idxJumped: 6),
      HoleToGo(idx: 12, idxJumped: 9)
    ]),
    HoleConfig(idx: 6, point: Point(3 * dx, 1 * dy), holesToGo: [
      HoleToGo(idx: 8, idxJumped: 7),
      HoleToGo(idx: 13, idxJumped: 10)
    ]),
    HoleConfig(idx: 7, point: Point(5 * dx, 1 * dy), holesToGo: [
      HoleToGo(idx: 5, idxJumped: 6),
      HoleToGo(idx: 12, idxJumped: 10)
    ]),
    HoleConfig(idx: 8, point: Point(7 * dx, 1 * dy), holesToGo: [
      HoleToGo(idx: 6, idxJumped: 7),
      HoleToGo(idx: 13, idxJumped: 11)
    ]),
    //-----------------  line 2
    HoleConfig(idx: 9, point: Point(2 * dx, 2 * dy), holesToGo: [
      HoleToGo(idx: 11, idxJumped: 10),
      HoleToGo(idx: 0, idxJumped: 5),
      HoleToGo(idx: 2, idxJumped: 6),
      HoleToGo(idx: 14, idxJumped: 12)
    ]),
    HoleConfig(idx: 10, point: Point(4 * dx, 2 * dy), holesToGo: [
      HoleToGo(idx: 1, idxJumped: 6),
      HoleToGo(idx: 3, idxJumped: 7),
    ]),
    HoleConfig(idx: 11, point: Point(6 * dx, 2 * dy), holesToGo: [
      HoleToGo(idx: 9, idxJumped: 10),
      HoleToGo(idx: 2, idxJumped: 7),
      HoleToGo(idx: 4, idxJumped: 8),
      HoleToGo(idx: 14, idxJumped: 13),
    ]),
    //-----------------  line 3
    HoleConfig(idx: 12, point: Point(3 * dx, 3 * dy), holesToGo: [
      HoleToGo(idx: 5, idxJumped: 9),
      HoleToGo(idx: 7, idxJumped: 10),
    ]),
    HoleConfig(idx: 13, point: Point(5 * dx, 3 * dy), holesToGo: [
      HoleToGo(idx: 6, idxJumped: 10),
      HoleToGo(idx: 8, idxJumped: 11),
    ]),
    //-----------------  line 4
    HoleConfig(
      idx: 14,
      point: Point(4 * dx, 4 * dy),
      holesToGo: [
        HoleToGo(idx: 9, idxJumped: 12),
        HoleToGo(idx: 11, idxJumped: 13),
      ],
      hasInitialPeg: false,
    ),
  ];
}
