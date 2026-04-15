import 'package:flutter/material.dart';

class DrinkSelectionProvider extends ChangeNotifier {
  final Map<int, bool> _selectedItems = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
  };

  Map<int, bool> get selectedItems => _selectedItems;

  bool isSelected(int index) => _selectedItems[index] ?? false;

  void toggleSelection(int index) {
    _selectedItems[index] = !_selectedItems[index]!;
    notifyListeners();
  }

  void clearAll() {
    for (var key in _selectedItems.keys) {
      _selectedItems[key] = false;
    }
    notifyListeners();
  }
}
