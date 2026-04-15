import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  final Set<int> _favorites = {};

  bool isFavorite(int index) => _favorites.contains(index);

  void addFavorite(int index) {
    _favorites.add(index);
    notifyListeners();
  }

  void removeFavorite(int index) {
    _favorites.remove(index);
    notifyListeners();
  }
}
