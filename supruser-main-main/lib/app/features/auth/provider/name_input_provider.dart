// phone_input_provider.dart or a new file like name_input_provider.dart
import 'package:flutter/material.dart';

class NameInputProvider extends ChangeNotifier {
  String _name = '';

  String get name => _name;

  bool get isValid => _name.trim().isNotEmpty;

  void updateName(String value) {
    _name = value;
    notifyListeners();
  }
}
