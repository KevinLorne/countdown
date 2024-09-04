import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GameScreen extends StatefulWidget {
  final String difficulty;
  final int consonants;
  final int vowels;
  final Function(String, int, String) onAddScore;

  const GameScreen({
    super.key,
    required this.difficulty,
    required this.consonants,
    required this.vowels,
    required this.onAddScore,
  });

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> letters = [];
  String word = '';
  int score = 0;
  int _timeLeft = 90;
  Timer? _timer;
  final Random _random = Random();
  bool _canType = true;
  int _highestScore = 0;
  String playerName = '';
  int totalWords = 0;
  bool _nameSubmitted = false;

  final List<Map<String, dynamic>> _localScores = [];

  // 1. Declare a TextEditingController
  final TextEditingController _wordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeGame();
    totalWords = widget.consonants + widget.vowels;
    // Optionally start adding letters or wait for user input
  }

  void _initializeGame() {
    switch (widget.difficulty) {
      case 'Easy':
        _timeLeft = 90;
        break;
      case 'Medium':
        _timeLeft = 60;
        break;
      case 'Hard':
        _timeLeft = 30;
        break;
    }
  }

  void startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer?.cancel();
          _canType = false;
          validateWord();
        }
      });
    });
  }

  void addConsonant() {
    const String consonants = 'BCDFGHJKLMNPQRSTVWXYZ';
    if (letters.length < totalWords) {
      setState(() {
        if (letters.where((letter) => consonants.contains(letter)).length <
            widget.consonants) {
          letters.add(consonants[_random.nextInt(consonants.length)]);
        }
        if (letters.length == totalWords) {
          startTimer();
        }
      });
    }
  }

  void addVowel() {
    const String vowels = 'AEIOU';
    if (letters.length < totalWords) {
      setState(() {
        if (letters.where((letter) => vowels.contains(letter)).length <
            widget.vowels) {
          letters.add(vowels[_random.nextInt(vowels.length)]);
        }
        if (letters.length == totalWords) {
          startTimer();
        }
      });
    }
  }

  bool isWordValid() {
    List<String> tempLetters = List.from(letters);

    for (int i = 0; i < word.length; i++) {
      String letter = word[i].toUpperCase();
      if (!tempLetters.contains(letter)) {
        return false;
      } else {
        tempLetters.remove(letter);
      }
    }
    return true;
  }

  Future<void> validateWord() async {
    if (!isWordValid()) {
      setState(() {
        score = 0;
      });
      return;
    }

    final response = await http.get(
      Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'),
    );

    if (response.statusCode == 200) {
      setState(() {
        score = word.length;
      });

      _localScores.add({'word': word, 'score': score, 'player': playerName});

      if (score > _highestScore) {
        setState(() {
          _highestScore = score;
        });
      }
    } else {
      setState(() {
        score = 0;
      });
    }

    // 5. Clear the TextField after processing the word
    _wordController.clear();
    // Optionally, reset the 'word' variable
    setState(() {
      word = '';
    });
  }

  void _saveScore() {
    if (_highestScore > 0 && playerName.isNotEmpty) {
      String highestScoringWord = '';
      int highestScore = 0;

      for (var scoreEntry in _localScores) {
        if (scoreEntry['score'] > highestScore) {
          highestScoringWord = scoreEntry['word'];
          highestScore = scoreEntry['score'];
        }
      }

      if (highestScoringWord.isNotEmpty) {
        widget.onAddScore(highestScoringWord, highestScore, playerName);
        setState(() {
          _nameSubmitted = true;
        });
      }
    }
  }

  void shuffleLetters() {
    setState(() {
      letters.shuffle(_random);
    });
  }

  @override
  Widget build(BuildContext context) {
    final int highestScore = _localScores.isNotEmpty
        ? _localScores
            .map((scoreEntry) => scoreEntry['score'] as int)
            .reduce((a, b) => a > b ? a : b)
        : 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Countdown')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_timeLeft == 0 ? 'Game Over' : 'Time Left: $_timeLeft',
              style: const TextStyle(fontSize: 22)),
          if (letters.length < totalWords) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: addConsonant,
                  child: const Text('Add Consonant'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addVowel,
                  child: const Text('Add Vowel'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            letters.isEmpty
                ? const Text(
                    'Pick your letters',
                    style: TextStyle(fontSize: 20),
                  )
                : Text(
                    'Letters: ${letters.join(' ')}',
                    style: const TextStyle(fontSize: 20),
                  ),
          ] else ...[
            Text(
              'Letters: ${letters.join(' ')}',
              style: const TextStyle(fontSize: 30),
            ),
            ElevatedButton(
              onPressed: shuffleLetters,
              child: const Text('Shuffle Letters'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _wordController,
                // 4. Attach the controller
                style: const TextStyle(fontSize: 15),
                onChanged: (value) => word = value,
                decoration: const InputDecoration(hintText: 'Enter your word'),
                enabled: _canType,
              ),
            ),
            ElevatedButton(
              onPressed: _canType ? validateWord : null,
              child: const Text('Submit Word'),
            ),
            Text('Score: $score'),
            if (!_canType && highestScore != 0) ...[
              const SizedBox(height: 20),
              Text(
                ' Highest Score: $highestScore',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (!_nameSubmitted)
                TextField(
                  onChanged: (value) {
                    setState(() {
                      playerName = value;
                    });
                  },
                  decoration: const InputDecoration(hintText: 'Your Name'),
                ),
              const SizedBox(height: 10),
              if (!_nameSubmitted)
                ElevatedButton(
                  onPressed: _saveScore,
                  child: const Text('Save Score'),
                ),
            ],
          ],
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _localScores.length,
              itemBuilder: (context, index) {
                final scoreEntry = _localScores[index];
                return ListTile(
                  title: Text('Word: ${scoreEntry['word']}'),
                  subtitle: Text('Score: ${scoreEntry['score']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _wordController.dispose();
    super.dispose();
  }
}
