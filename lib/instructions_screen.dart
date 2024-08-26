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
