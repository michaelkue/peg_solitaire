import 'package:flutter/material.dart';

/// draw a hole and pass a tap event handler;
/// add some formatting, dependent on whether the hole is marked
/// (e.g. as possible jump target)
class Hole extends StatelessWidget {
  final int idx;
  final double size;
  final bool marked;
  final Function(int idx) onTap;

  Hole({this.idx, this.size, this.marked, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: size,
        height: size,
        child: Center(
          child: Container(
            width: size * 0.7,
            height: size * 0.7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: marked ? 5.0 : 1.0,
                color: marked ? Colors.green : Colors.black,
              ),
              color: Colors.white70,
            ),
          ),
        ),
      ),
      onTap: _onTap,
    );
  }

  void _onTap() {
    onTap(idx);
  }
}
