import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  int itemCount = 1;
  int itemPrice = 17;

  void increaseItem() {
    itemCount++;
    notifyListeners();
  }

  void decreaseItem() {
    if (itemCount > 1) {
      itemCount--;
      notifyListeners();
    }
  }

  int get totalPrice => itemCount * itemPrice;
}
