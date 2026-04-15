import 'package:flutter/material.dart';

class PhoneInputProvider with ChangeNotifier {
  String _phone = '';
  String _countryCode = '+1';
  String _countryFlag = '🇺🇸';

  String get phone => _phone;
  String get countryCode => _countryCode;
  String get countryFlag => _countryFlag;

  void updatePhone(String value) {
    _phone = value;
    notifyListeners();
  }

  void clearPhone() {
    _phone = '';
    notifyListeners();
  }

  void updateCountry(String code, String dialCode, String flag) {
    _countryCode = dialCode;
    _countryFlag = flag;
    notifyListeners();
  }
}
