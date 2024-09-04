import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Countdown Game')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 100,
              height: 100,
              child: Icon(
                Icons.alarm_outlined,
                size: 100,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/game');
              },
              child: const Text('Start Game'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Text('Settings'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/instructions');
              },
              child: const Text('Instructions'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/scores');
              },
              child: const Text('View Scores'),
            ),
          ],
        ),
      ),
    );
  }
}
