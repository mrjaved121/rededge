import 'package:flutter/material.dart';

class BankProvider extends ChangeNotifier {
  String? _selectedBank;

  String? get selectedBank => _selectedBank;

  void setSelectedBank(String? bank) {
    _selectedBank = bank;
    notifyListeners();
  }
}
