import 'package:flutter/material.dart';

class CheckoutProvider extends ChangeNotifier {
  // Collection & Delivery
  String? _selectedAddress;
  DateTime? _collectionDate;
  String? _collectionTime;
  DateTime? _deliveryDate;
  String? _deliveryTime;

  // Driver Instructions
  String _collectionPreference = 'No preference';
  String _deliveryPreference = 'No preference';

  // Payment
  double _tipAmount = 0.0;
  String? _promoCode;
  double _subtotal = 0.0;
  double _deliveryFee = 9.50;

  // Getters
  String? get selectedAddress => _selectedAddress;
  DateTime? get collectionDate => _collectionDate;
  String? get collectionTime => _collectionTime;
  DateTime? get deliveryDate => _deliveryDate;
  String? get deliveryTime => _deliveryTime;
  String get collectionPreference => _collectionPreference;
  String get deliveryPreference => _deliveryPreference;
  double get tipAmount => _tipAmount;
  String? get promoCode => _promoCode;
  double get subtotal => _subtotal;
  double get deliveryFee => _deliveryFee;

  double get estimatedTotal =>
      _subtotal + _deliveryFee + _tipAmount;

  // Setters
  void setAddress(String address) {
    _selectedAddress = address;
    notifyListeners();
  }

  void setCollectionDate(DateTime date, String time) {
    _collectionDate = date;
    _collectionTime = time;
    notifyListeners();
  }

  void setDeliveryDate(DateTime date, String time) {
    _deliveryDate = date;
    _deliveryTime = time;
    notifyListeners();
  }

  void setCollectionPreference(String preference) {
    _collectionPreference = preference;
    notifyListeners();
  }

  void setDeliveryPreference(String preference) {
    _deliveryPreference = preference;
    notifyListeners();
  }

  void setTip(double amount) {
    _tipAmount = amount;
    notifyListeners();
  }

  void setPromoCode(String code) {
    _promoCode = code;
    notifyListeners();
  }

  void setSubtotal(double amount) {
    _subtotal = amount;
    notifyListeners();
  }

  void resetCheckout() {
    _selectedAddress = null;
    _collectionDate = null;
    _collectionTime = null;
    _deliveryDate = null;
    _deliveryTime = null;
    _collectionPreference = 'No preference';
    _deliveryPreference = 'No preference';
    _tipAmount = 0.0;
    _promoCode = null;
    notifyListeners();
  }
}
