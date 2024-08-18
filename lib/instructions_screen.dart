import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Instructions')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Welcome to the Countdown Game!\n\n'
              '1. Start by choosing your difficulty level and the number of consonants and vowels.\n'
              '2. You will be given 9 random letters to form the longest word you can.\n'
              '3. The timer starts once the letters are displayed. You have one guess.\n'
              '4. Submit your word before the timer runs out.\n'
              '5. Your score will be based on the length of the valid word.\n\n'
              'Good luck!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class HighScoresScreen extends StatelessWidget {
  final List<Map<String, dynamic>> scores = [
    {'word': 'EXAMPLE', 'score': 7, 'player': 'ABC'},
    {'word': 'TEST', 'score': 4, 'player': 'XYZ'},
  ];

  HighScoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('High Scores')),
      body: ListView.builder(
        itemCount: scores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${scores[index]['word']} (${scores[index]['score']} points)'),
            subtitle: Text('Player: ${scores[index]['player']}'),
          );
        },
      ),
    );
  }
}
