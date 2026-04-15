// view_toggle_provider.dart
import 'package:flutter/material.dart';

class ViewToggleProvider with ChangeNotifier {
  bool _showAlternateList = false;

  bool get showAlternateList => _showAlternateList;

  void toggleView() {
    _showAlternateList = !_showAlternateList;
    notifyListeners();
  }

  void showMainList() {
    _showAlternateList = false;
    notifyListeners();
  }

  void showAlternateListView() {
    _showAlternateList = true;
    notifyListeners();
  }
}
