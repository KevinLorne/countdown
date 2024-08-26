import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Function(String, int, int) onSettingsChanged;

  const SettingsScreen({super.key, required this.onSettingsChanged});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _difficulty = 'Easy';
  int _consonants = 5;
  int _vowels = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _difficulty,
            onChanged: (String? newValue) {
              setState(() {
                _difficulty = newValue!;
              });
            },
            items: <String>['Easy', 'Medium', 'Hard']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Consonants: $_consonants'),
              Slider(
                value: _consonants.toDouble(),
                min: 1,
                max: 9,
                divisions: 8,
                label: _consonants.toString(),
                onChanged: (double value) {
                  setState(() {
                    _consonants = value.toInt();
                    _vowels = 10 - _consonants;
                  });
                },
              ),
            ],
          ),
          Text('Vowels: $_vowels'),
          ElevatedButton(
            onPressed: () {
              widget.onSettingsChanged(_difficulty, _consonants, _vowels);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
