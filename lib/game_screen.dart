import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../models/card_model.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Card Matching Game")),
      body: Consumer<GameProvider>(
        builder: (context, game, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: game.cards.length,
              itemBuilder: (context, index) {
                return CardWidget(card: game.cards[index], index: index);
              },
            ),
          );
        },
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final CardModel card;
  final int index;

  const CardWidget({super.key, required this.card, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<GameProvider>().flipCard(index),
      child: Container(
        decoration: BoxDecoration(
          color: card.isFaceUp ? Colors.white : Colors.blueGrey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: card.isFaceUp
            ? Image.asset(card.image, fit: BoxFit.cover)
            : const SizedBox.shrink(),
      ),
    );
  }
}
