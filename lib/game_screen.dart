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
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return RotationYTransition(turns: animation, child: child);
        },
        child: card.isFaceUp
            ? Image.asset(card.image, key: ValueKey(card.id))
            : Container(
                key: ValueKey(-card.id),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
      ),
    );
  }
}

class RotationYTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> turns;

  const RotationYTransition({super.key, required this.child, required this.turns});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: turns,
      child: child,
      builder: (context, child) {
        final double angle = turns.value * 3.1415926535897932;
        return Transform(
          transform: Matrix4.rotationY(angle),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}
