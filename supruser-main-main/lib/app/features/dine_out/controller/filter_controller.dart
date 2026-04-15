import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  final List<String> allFilters = [
    'Nearby',
    'Offers',
    'Rated 4+',
    'Open now',
    'Alcohol Free',
  ];

  final Set<String> _selectedFilters = {};

  Set<String> get selectedFilters => _selectedFilters;

  void toggleFilter(String filter) {
    if (_selectedFilters.contains(filter)) {
      _selectedFilters.remove(filter);
    } else {
      _selectedFilters.add(filter);
    }
    notifyListeners();
  }

  bool isSelected(String filter) => _selectedFilters.contains(filter);
}
