import 'package:flutter/material.dart';
import '../models/card_model.dart';

class GameProvider extends ChangeNotifier {
  List<CardModel> _cards = [];

  List<CardModel> get cards => _cards;

  GameProvider() {
    _initializeGame();
  }

  void _initializeGame() {
    List<String> images = [
      'assets/card1.png', 'assets/card1.png',
      'assets/card2.png', 'assets/card2.png',
      'assets/card3.png', 'assets/card3.png',
      'assets/card4.png', 'assets/card4.png',
      'assets/card5.png', 'assets/card5.png',
      'assets/card6.png', 'assets/card6.png',
      'assets/card7.png', 'assets/card7.png',
      'assets/card8.png', 'assets/card8.png',
    ];

    images.shuffle();

    _cards = List.generate(16, (index) => 
      CardModel(id: index, image: images[index])
    );

    notifyListeners();
  }

  void flipCard(int index) {
    _cards[index].isFaceUp = !_cards[index].isFaceUp;
    notifyListeners();
  }
}
