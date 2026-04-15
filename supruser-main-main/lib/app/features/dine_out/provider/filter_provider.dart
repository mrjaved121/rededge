import 'package:flutter/material.dart';

class FilterProviders with ChangeNotifier {
  int selectedSortIndex = 0;
  bool isOffersSelected = false;
  void selectSort(int index) {
    selectedSortIndex = index;
    notifyListeners();
  }

  void toggleOffers() {
    isOffersSelected = !isOffersSelected;
    notifyListeners();
  }

  int selectedIndex = -1; // Initially, no checkbox is selected

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners(); // Update the UI when selection changes
  }

  void clearAll() {
    selectedSortIndex = 0;
    isOffersSelected = false;
    notifyListeners();
  }

  bool get isAnythingSelected =>
      selectedSortIndex != 0 || isOffersSelected == true;
}
