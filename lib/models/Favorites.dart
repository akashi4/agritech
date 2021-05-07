import 'package:flutter/material.dart';

class Favorite with ChangeNotifier {
  List favorites = [];

  void addToFavorite(item) {
    favorites.add(item);
    notifyListeners();
  }

  removeInFavorite(inItem) {
    favorites.firstWhere((item) {
      favorites.remove(inItem == item);
    });
  }
}
