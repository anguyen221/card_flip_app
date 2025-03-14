import 'package:flutter/material.dart';
import 'game_screen.dart';

void main() {
  runApp(const CardMatchingApp());
}

class CardMatchingApp extends StatelessWidget {
  const CardMatchingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Matching Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameScreen(),
    );
  }
}
