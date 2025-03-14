import 'package:flutter/material.dart';

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

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Card Matching Game")),
      body: const Center(
        child: Text("Game Screen"),
      ),
    );
  }
}
