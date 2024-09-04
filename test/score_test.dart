import 'package:countdown/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HighScoresScreen: Display sorted scores',
      (WidgetTester tester) async {
    final List<Map<String, dynamic>> scores = [
      {'word': 'flutter', 'score': 7, 'player': 'Alice'},
      {'word': 'dart', 'score': 4, 'player': 'Bob'},
      {'word': 'widget', 'score': 6, 'player': 'Charlie'},
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: HighScoresScreen(scores: scores),
      ),
    );

    expect(find.text('Word: flutter (7 points)'), findsOneWidget);
    expect(find.text('Word: widget (6 points)'), findsOneWidget);
    expect(find.text('Word: dart (4 points)'), findsOneWidget);
  });
}
