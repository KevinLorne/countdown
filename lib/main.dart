import 'package:countdown/score.dart';
import 'package:countdown/setting_screen.dart';
import 'package:flutter/material.dart';
import 'game_screen.dart';
import 'main_menu.dart';
import 'instructions_screen.dart';

void main() => runApp(const CountdownGame());

class CountdownGame extends StatefulWidget {
  const CountdownGame({super.key});

  @override
  _CountdownGameState createState() => _CountdownGameState();
}

class _CountdownGameState extends State<CountdownGame> {
  final List<Map<String, dynamic>> highScores = [];

  String difficulty = 'Easy';
  int consonants = 5;
  int vowels = 4;


  void addScore(String word, int score, String player) {
    setState(() {
      highScores.add({'word': word, 'score': score, 'player': player});
    });
  }

  void updateSettings(String newDifficulty, int newConsonants, int newVowels) {
    setState(() {
      difficulty = newDifficulty;
      consonants = newConsonants;
      vowels = newVowels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Game',
      home: const MainMenu(),
      routes: {
        '/game': (context) => GameScreen(
          difficulty: difficulty,
          consonants: consonants,
          vowels: vowels,
          onAddScore: addScore,
        ),
        '/settings': (context) => SettingsScreen(onSettingsChanged: updateSettings),
        '/instructions': (context) => const InstructionsScreen(),
        '/scores': (context) => HighScoresScreen(scores: highScores),
      },
    );
  }
}
