import 'package:flutter/material.dart';

class SavedLocationProvider with ChangeNotifier {
  bool _isSaved = false;

  bool get isSaved => _isSaved;

  void saveLocation() {
    _isSaved = true;
    notifyListeners();
  }

  void removeLocation() {
    _isSaved = false;
    notifyListeners();
  }
}
