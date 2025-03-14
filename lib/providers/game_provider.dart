import 'package:flutter/material.dart';
import '../models/card_model.dart';

class GameProvider extends ChangeNotifier {
  List<CardModel> cards = [];
  int? firstFlippedIndex;
  bool isChecking = false;

  GameProvider() {
    _initializeCards();
  }

  void _initializeCards() {
    List<String> images = [
      'assets/card1.png',
      'assets/card2.png',
      'assets/card3.png',
      'assets/card4.png',
      'assets/card5.png',
      'assets/card6.png',
      'assets/card7.png',
      'assets/card8.png',
    ];
    
    cards = List.generate(8, (index) => CardModel(id: index, image: images[index]))
      ..addAll(List.generate(8, (index) => CardModel(id: index + 8, image: images[index])));

    cards.shuffle();
    notifyListeners();
  }

  void flipCard(int index) {
    if (isChecking || cards[index].isFaceUp || cards[index].isMatched) return;

    cards[index].isFaceUp = true;
    notifyListeners();

    if (firstFlippedIndex == null) {
      firstFlippedIndex = index;
    } else {
      _checkMatch(index);
    }
  }

  void _checkMatch(int secondIndex) {
    int firstIndex = firstFlippedIndex!;
    isChecking = true;

    if (cards[firstIndex].image == cards[secondIndex].image) {
      cards[firstIndex].isMatched = true;
      cards[secondIndex].isMatched = true;
      isChecking = false;
      if (checkWin()) {
        debugPrint("Test win");
      }
    } else {
      Future.delayed(const Duration(milliseconds: 1000), () {
        cards[firstIndex].isFaceUp = false;
        cards[secondIndex].isFaceUp = false;
        isChecking = false;
        notifyListeners();
      });
    }

    firstFlippedIndex = null;
    notifyListeners();
  }

  bool checkWin() {
    return cards.every((card) => card.isMatched);
  }
}
