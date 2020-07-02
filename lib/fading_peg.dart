import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:peg_solitaire/peg.dart';

class Fading {
  final double opacity;
  final double sizeFactor;

  Fading({this.opacity, this.sizeFactor});

  static Fading lerp(Fading begin, Fading end, double t) {
    return Fading(
        opacity: lerpDouble(begin.opacity, end.opacity, t),
        sizeFactor: lerpDouble(begin.sizeFactor, end.sizeFactor, t));
  }
}

class FadingTween extends Tween<Fading> {
  FadingTween(Fading begin, Fading end) : super(begin: begin, end: end);

  @override
  Fading lerp(double t) => Fading.lerp(begin, end, t);
}

class FadingPeg extends StatefulWidget {
  final Point<double> position;
  final Function() onFinished;
  final double size;

  FadingPeg({this.position, this.onFinished, this.size});

  FadingPegState createState() =>
      FadingPegState(position: position, onFinished: onFinished, size: size);
}

class FadingPegState extends State<FadingPeg> with TickerProviderStateMixin {
  final Point<double> position;
  final Function() onFinished;
  final double size;
  AnimationController controller;
  Animation<double> animation;
  Fading fading = Fading(opacity: 1.0, sizeFactor: 1.0);
  FadingTween fadingTween = FadingTween(Fading(opacity: 1.0, sizeFactor: 1.0),
      Fading(opacity: 0.0, sizeFactor: 1.5));
  Animation<Fading> fadingAnimation;

  FadingPegState({this.position, this.onFinished, this.size});

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          this._onFadingFinished();
        }
      });

    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    fadingAnimation = fadingTween.animate(animation)
      ..addListener(() {
        setState(() {
          this.fading = this.fadingAnimation.value;
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: FractionalOffset(position.x, position.y),
        child: Opacity(
            opacity: fading.opacity,
            child: Peg(idx: 0, size: size * fading.sizeFactor)));
  }

  void _onFadingFinished() {
    this.onFinished();
  }
}
