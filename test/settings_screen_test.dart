import 'package:countdown/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SettingsScreen: Change difficulty and consonants',
      (WidgetTester tester) async {
    String updatedDifficulty = 'Easy';
    int updatedConsonants = 5;
    int updatedVowels = 4;

    await tester.pumpWidget(
      MaterialApp(
        home: SettingsScreen(
          onSettingsChanged: (String difficulty, int consonants, int vowels) {
            updatedDifficulty = difficulty;
            updatedConsonants = consonants;
            updatedVowels = vowels;
          },
        ),
      ),
    );

    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Medium').last);
    await tester.pump();

    await tester.drag(find.byType(Slider), const Offset(200.0, 0.0));
    await tester.pump();

    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(updatedDifficulty, 'Medium');
    expect(updatedConsonants > 5, true);
    expect(updatedVowels < 4, true);
  });
}
