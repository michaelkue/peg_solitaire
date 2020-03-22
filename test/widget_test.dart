// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:peg_solitaire/main.dart';

void main() {
  testWidgets('Game setup smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify right game instructions.
    expect(find.text('Please tap a highlighted peg'), findsOneWidget);
    expect(find.text('Please tap a highlighted hole'), findsNothing);

    WidgetPredicate pegMovablePredicate = (Widget widget) =>  widget is Container && widget.decoration == BoxDecoration(color: Colors.lime[500]);
  });
}
