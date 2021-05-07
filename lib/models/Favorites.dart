import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

class Favorite with ChangeNotifier {
  List<RssItem> _favorites = [];

  List<RssItem> get favorites {
    return [..._favorites];
  }

  int get itemCounts {
    return _favorites.length;
  }

  void addToFavorite(RssItem item) {
    _favorites.add(item);
    print(favorites);
    notifyListeners();
  }

  removeInFavorite(RssItem inItem) {
    _favorites.firstWhere((RssItem item) {
      _favorites.remove(inItem == item);
    });
  }

  /* bool isEmpty() {
    if (_favorites == null || _favorites == [])
      return true;
    else
      return false;
  } */
}
