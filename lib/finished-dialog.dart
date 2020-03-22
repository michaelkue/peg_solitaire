import 'package:flutter/material.dart';

class FinishedDialog {
  final BuildContext context;
  final Function() onRepeat;

  FinishedDialog({this.context, this.onRepeat});

  void show() {
    const title = 'Game finished';
    const content = 'Do you want to play again?';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
                RaisedButton(
                  child: const Text('Restart'),
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                  elevation: 4.0,
                  splashColor: Colors.blueGrey,
                  onPressed: onRepeat,
                ),
            ],
          );
        });
  }
}
