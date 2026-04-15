import 'package:flutter/material.dart';

class FoodItemProvider extends ChangeNotifier {
  int? selectedIndex;
  int quantity = 0;

  void selectCombo(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void increaseQty() {
    quantity++;
    notifyListeners();
  }

  void decreaseQty() {
    if (quantity > 0) quantity--;
    notifyListeners();
  }
}
