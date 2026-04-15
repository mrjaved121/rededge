import 'package:flutter/material.dart';

class SelectionProvider with ChangeNotifier {
  int? _selectedIndex;

  int? get selectedIndex => _selectedIndex;

  void selectIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
