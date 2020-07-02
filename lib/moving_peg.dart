import 'dart:math';
import 'package:flutter/material.dart';
import 'package:peg_solitaire/peg.dart';

class MovingPeg extends StatefulWidget {
  final double size;
  final Point<double> begin;
  final Point<double> end;
  final Function() onFinished;

  MovingPeg({this.size, this.begin, this.end, this.onFinished});

  @override
  State<StatefulWidget> createState() => MovingPegState(
      size: size, begin: begin, end: end, onFinished: onFinished);
}

class MovingPegState extends State<MovingPeg> with TickerProviderStateMixin {
  final double size;
  final Point<double> begin;
  final Point<double> end;
  final Function() onFinished;

  AnimationController moveController;
  Animation<double> animation; // = Tween(begin: begin, end: end);
  Animation<Point<double>> moveAnimation; // = Tween(begin: begin, end: end);
  Point<double> movingPosition = Point(0.0, 0.0);

  MovingPegState({this.size, this.begin, this.end, this.onFinished});

  @override
  void initState() {
    super.initState();
    moveController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          this._onMovingFinished();
        }
      });
    animation = CurvedAnimation(parent: moveController, curve: Curves.easeInOut);
    moveAnimation =
        Tween(begin: this.begin, end: this.end).animate(animation)
          ..addListener(() {
            setState(() {
              this.movingPosition = moveAnimation.value;
            });
          });
    moveController.forward();
  }

  @override
  void dispose() {
    moveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset(movingPosition.x, movingPosition.y),
      child: Peg(
        idx: 0,
        size: size,
        isMovable: true,
      ),
    );
  }

  void _onMovingFinished() {
    this.onFinished();
  }
}
