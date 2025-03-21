import 'package:flutter/material.dart';
import '../models/card_model.dart';

class GameProvider extends ChangeNotifier {
  List<CardModel> cards = [];
  int? firstFlippedIndex;
  bool isChecking = false;
  BuildContext? _context;

  GameProvider() {
    _initializeCards();
  }

  void setContext(BuildContext context) {
    _context = context;
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
        _showWinDialog();
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

  void _showWinDialog() {
    if (_context == null) return;

    Future.delayed(const Duration(milliseconds: 300), () {
      showDialog(
        context: _context!,
        builder: (context) {
          return AlertDialog(
            title: const Text("You won!"),
            content: const Text("Good job on matching all the cards!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _initializeCards();
                  notifyListeners();
                },
                child: const Text("Play Again"),
              ),
            ],
          );
        },
      );
    });
  }
}
