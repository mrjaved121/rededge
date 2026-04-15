import 'package:flutter/material.dart';

class FoodToggleProvider with ChangeNotifier {
  bool _isVeg = true;

  bool get isVeg => _isVeg;

  void toggle() {
    _isVeg = !_isVeg;
    notifyListeners();
  }
}
