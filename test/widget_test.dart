// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_scientific_calculator/widgets/display.dart';

void main() {
  group('Display Widget Tests', () {
    testWidgets('Display shows expression and result', (WidgetTester tester) async {
      // Build our widget and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Display(
              expression: '2 + 2',
              result: '4',
            ),
          ),
        ),
      );

      // Verify that the expression and result are displayed
      expect(find.text('2 + 2'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
    });

    testWidgets('Display shows default values when empty', (WidgetTester tester) async {
      // Build our widget with default values
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const Display(),
          ),
        ),
      );

      // Verify default values
      expect(find.text(''), findsOneWidget); // empty expression
      expect(find.text('0'), findsOneWidget); // default result
    });
  });
}
