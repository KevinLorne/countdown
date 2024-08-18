import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> letters = [];
  String word = '';
  int score = 0;
  int _timeLeft = 90;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    generateLetters();
    startTimer();
  }

  void generateLetters() {
    setState(() {
      letters = ['C', 'A', 'T', 'D', 'O', 'G', 'B', 'E', 'R'];
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer.cancel();
          validateWord();
        }
      });
    });
  }

  Future<void> validateWord() async {
    final response = await http.get(
      Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'),
    );

    if (response.statusCode == 200) {
      setState(() {
        score = word.length; // 1 point per letter
      });
    } else {
      setState(() {
        score = 0; // Invalid word
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Screen')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Time Left: $_timeLeft'),
          Text('Letters: ${letters.join(' ')}'),
          TextField(
            onChanged: (value) => word = value,
            decoration: const InputDecoration(hintText: 'Enter your word'),
          ),
          ElevatedButton(
            onPressed: validateWord,
            child: const Text('Submit Word'),
          ),
          Text('Score: $score'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}