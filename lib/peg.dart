import 'package:flutter/material.dart';

/// draw a peg and pass a tap event handler;
/// add formatting, dependent on whether the peg is movable or selected;
class Peg extends StatelessWidget {
  final int idx;
  final double size;
  final bool isMovable;
  final bool isSelected;
  final Function(int idx) onTap;

  Peg(
      {Key key,
      this.idx,
      this.size,
      this.isMovable = false,
      this.isSelected = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 4.0,
            color: Colors.black,
          ),
          color: isSelected
              ? Colors.green
              : (isMovable ? Colors.lime[500] : Colors.lime[200]),
        ),
        width: size,
        height: size,
      ),
      onTap: _onTap,
    );
  }

  void _onTap() {
    onTap(idx);
  }
}
