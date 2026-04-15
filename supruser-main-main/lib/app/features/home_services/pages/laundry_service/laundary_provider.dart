import 'package:flutter/material.dart';

import 'laundar_data_model.dart';

class LaundryProvider extends ChangeNotifier {
  String _selectedTab = 'Tops';
  final Map<LaundryItem, int> _selectedItems = {};
  final Map<LaundryPackage, int> _selectedPackages = {};
  double _estimatedBill = 0.0;

  // Getters
  String get selectedTab => _selectedTab;
  Map<LaundryItem, int> get selectedItems => _selectedItems;
  Map<LaundryPackage, int> get selectedPackages => _selectedPackages;
  double get estimatedBill => _estimatedBill;

  List<LaundryItem> get allSelectedItems => _selectedItems.keys.toList();
  List<LaundryPackage> get allSelectedPackages => _selectedPackages.keys.toList();

  // Select Tab
  void selectTab(String tab) {
    _selectedTab = tab;
    notifyListeners();
  }

  // Add Item
  void addItem(LaundryItem item) {
    if (!_selectedItems.containsKey(item)) {
      _selectedItems[item] = 1;
      _calculateBill();
      notifyListeners();
    }
  }

  // Remove Item
  void removeItem(LaundryItem item) {
    _selectedItems.remove(item);
    _calculateBill();
    notifyListeners();
  }

  // Increase Quantity
  void increaseQuantity(LaundryItem item) {
    if (_selectedItems.containsKey(item)) {
      _selectedItems[item] = (_selectedItems[item] ?? 1) + 1;
      _calculateBill();
      notifyListeners();
    }
  }

  // Decrease Quantity
  void decreaseQuantity(LaundryItem item) {
    if (_selectedItems.containsKey(item)) {
      int currentQty = _selectedItems[item] ?? 1;
      if (currentQty > 1) {
        _selectedItems[item] = currentQty - 1;
      } else {
        _selectedItems.remove(item);
      }
      _calculateBill();
      notifyListeners();
    }
  }

  // Get Item Quantity
  int getItemQuantity(LaundryItem item) {
    return _selectedItems[item] ?? 0;
  }

  // Check if Item is Selected
  bool isItemSelected(LaundryItem item) {
    return _selectedItems.containsKey(item);
  }

  // Add Package
  void addPackage(LaundryPackage package) {
    if (!_selectedPackages.containsKey(package)) {
      _selectedPackages[package] = 1;
      _calculateBill();
      notifyListeners();
    }
  }

  // Remove Package
  void removePackage(LaundryPackage package) {
    _selectedPackages.remove(package);
    _calculateBill();
    notifyListeners();
  }

  // Increase Package Quantity
  void increasePackageQuantity(LaundryPackage package) {
    if (_selectedPackages.containsKey(package)) {
      _selectedPackages[package] = (_selectedPackages[package] ?? 1) + 1;
      _calculateBill();
      notifyListeners();
    }
  }

  // Decrease Package Quantity
  void decreasePackageQuantity(LaundryPackage package) {
    if (_selectedPackages.containsKey(package)) {
      int currentQty = _selectedPackages[package] ?? 1;
      if (currentQty > 1) {
        _selectedPackages[package] = currentQty - 1;
      } else {
        _selectedPackages.remove(package);
      }
      _calculateBill();
      notifyListeners();
    }
  }

  // Get Package Quantity
  int getPackageQuantity(LaundryPackage package) {
    return _selectedPackages[package] ?? 0;
  }

  // Check if Package is Selected
  bool isPackageSelected(LaundryPackage package) {
    return _selectedPackages.containsKey(package);
  }

  // Calculate Bill
  void _calculateBill() {
    double total = 0.0;

    for (var entry in _selectedItems.entries) {
      total += entry.key.price * entry.value;
    }

    for (var entry in _selectedPackages.entries) {
      total += entry.key.price * entry.value;
    }

    _estimatedBill = total;
  }

  // Reset All
  void resetAll() {
    _selectedItems.clear();
    _selectedPackages.clear();
    _estimatedBill = 0.0;
    notifyListeners();
  }
}