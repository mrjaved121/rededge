import 'package:flutter/material.dart';

class CancelReasonProvider extends ChangeNotifier {
  String? _selectedReason;

  String? get selectedReason => _selectedReason;

  void selectReason(String reason) {
    _selectedReason = reason;
    notifyListeners();
  }

  bool get isSubmitEnabled => _selectedReason != null;
}
