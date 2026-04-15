import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  final Map<String, bool> _visibilityMap = {
    'newPassword': false,
    'confirmPassword': false,
    'oldPassword': false,
  };

  bool isVisible(String fieldKey) => _visibilityMap[fieldKey] ?? false;

  void toggleVisibility(String fieldKey) {
    _visibilityMap[fieldKey] = !(_visibilityMap[fieldKey] ?? false);
    notifyListeners();
  }
}
