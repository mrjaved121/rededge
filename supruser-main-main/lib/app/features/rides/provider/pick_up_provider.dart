import 'package:flutter/material.dart';

class PickupDetailsProvider with ChangeNotifier {
  bool _showPickupField = false;
  bool get showPickupField => _showPickupField;

  String locationName = '';
  String pickupDetails = '';

  void togglePickupField() {
    _showPickupField = !_showPickupField;
    notifyListeners();
  }

  void setLocationName(String value) {
    locationName = value;
    notifyListeners();
  }

  void setPickupDetails(String value) {
    pickupDetails = value;
    notifyListeners();
  }

  bool get isFormValid {
    if (locationName.trim().isEmpty) return false;
    if (_showPickupField && pickupDetails.trim().isEmpty) return false;
    return true;
  }
}
