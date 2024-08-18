import 'package:countdown/game_screen.dart';
import 'package:countdown/instructions_screen.dart';
import 'package:countdown/main_menu.dart';
import 'package:countdown/setting_screen.dart';
import 'package:flutter/material.dart';


void main() => runApp(const CountdownGame());

class CountdownGame extends StatelessWidget {
  const CountdownGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Game',
      home: const MainMenu(),
      routes: {
        '/game': (context) => const GameScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/instructions': (context) => const InstructionsScreen(),
        '/scores': (context) => HighScoresScreen(),
      },
    );
  }
}
