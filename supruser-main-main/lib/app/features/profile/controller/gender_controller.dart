import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/static_data.dart';

class GenderProvider extends ChangeNotifier {
  String _selectedGender = StaticData.model?.gender ?? 'Male';

  String get selectedGender => _selectedGender;

  void setGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }
}
