import 'package:flutter/material.dart';
import 'package:peg_solitaire/hole-config.dart';
import 'package:peg_solitaire/hole.dart';

/// draw all holes, places them according to the hole configuration;
class Board extends StatelessWidget {

  final double size;
  final List<int> holesMarked;
  final Function(int idx) onTap;
  final List<HoleConfig> holesConfig;


  Board({this.holesConfig, this.size, this.holesMarked, this.onTap});


  @override
  Widget build(BuildContext context) {
    return Stack(
              children: _buildHoles(holesConfig, holesMarked, this.size),
    );
  }

  List<Align> _buildHoles(List<HoleConfig> holesConfig, List<int> markedHoles, double size) =>
      List.generate(
          holesConfig.length,
          (i) => Align(
                alignment: FractionalOffset(holesConfig[i].point.x, holesConfig[i].point.y),
                child: Hole(
                  idx: i,
                  size: size,
                  marked: holesMarked.contains(i),
                  onTap: _onTap,
                ),
              ));


  _onTap(int idx) {
    onTap(idx);
  }
}
