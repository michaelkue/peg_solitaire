import 'package:flutter/material.dart';
import 'package:peg_solitaire/board_setting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peg Solitaire',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BoardSetting(title: 'Peg Solitaire'),
    );
  }
}

