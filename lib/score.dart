import 'package:flutter/material.dart';

class HighScoresScreen extends StatefulWidget {

  final List<Map<String, dynamic>> scores;

  const HighScoresScreen({super.key, required this.scores});

  @override
  _HighScoresScreenState createState() => _HighScoresScreenState();
}

class _HighScoresScreenState extends State<HighScoresScreen> {
  List<Map<String, dynamic>> get sortedScores {
    return List<Map<String, dynamic>>.from(widget.scores)
      ..sort((a, b) => b['score'].compareTo(a['score']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('High Scores')),
      body: ListView.builder(
        itemCount: sortedScores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Word: ${sortedScores[index]['word']} (${sortedScores[index]['score']} points)'),
            subtitle: Text('Player: ${sortedScores[index]['player']}'),
          );
        },
      ),
    );
  }
}
