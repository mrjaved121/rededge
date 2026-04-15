// ==================== PROVIDER FOR COLLECTION & DELIVERY ====================
// Create: lib/app/features/home_services/pages/laundry_service/providers/collection_delivery_provider.dart

import 'package:flutter/material.dart';

class CollectionDeliveryProvider extends ChangeNotifier {
  // Address
  String? _selectedAddress;

  // Collection
  String? _collectionDate;
  String? _collectionTime;
  int _selectedCollectionDayIndex = -1;
  int _selectedCollectionTimeIndex = -1;

  // Delivery
  String? _deliveryDate;
  String? _deliveryTime;
  String _deliveryType = 'door';
  int _selectedDeliveryDayIndex = -1;
  int _selectedDeliveryTimeIndex = -1;

  // Instructions
  String _collectionInstruction = 'no_preference';
  String _deliveryInstruction = 'no_preference';

  // Getters
  String? get selectedAddress => _selectedAddress;
  String? get collectionDate => _collectionDate;
  String? get collectionTime => _collectionTime;
  String? get deliveryDate => _deliveryDate;
  String? get deliveryTime => _deliveryTime;
  String get deliveryType => _deliveryType;
  String get collectionInstruction => _collectionInstruction;
  String get deliveryInstruction => _deliveryInstruction;
  int get selectedCollectionDayIndex => _selectedCollectionDayIndex;
  int get selectedCollectionTimeIndex => _selectedCollectionTimeIndex;
  int get selectedDeliveryDayIndex => _selectedDeliveryDayIndex;
  int get selectedDeliveryTimeIndex => _selectedDeliveryTimeIndex;

  // Available time slots
  final List<String> collectionDays = ['Today\nNov 8', 'Tomorrow\nNov 9', 'Monday\nNov 10'];
  final List<String> collectionTimes = [
    '09:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
    '12:00 PM - 01:00 PM',
    '01:00 PM - 02:00 PM',
    '02:00 PM - 03:00 PM',
    '03:00 PM - 04:00 PM',
    '04:00 PM - 05:00 PM',
  ];

  final List<String> deliveryDays = ['+2 Days\nMon', '+3 Days\nTue', '+4 Days\nWed'];
  final List<String> deliveryTimes = [
    'Anytime during the day',
    '09:00 AM - 12:00 PM',
    '12:00 PM - 03:00 PM',
    '03:00 PM - 06:00 PM',
    '06:00 PM - 09:00 PM',
  ];

  // Set address
  void setAddress(String address) {
    _selectedAddress = address;
    notifyListeners();
  }

  // Set collection schedule
  void setCollectionSchedule(int dayIndex, int timeIndex) {
    _selectedCollectionDayIndex = dayIndex;
    _selectedCollectionTimeIndex = timeIndex;
    _collectionDate = collectionDays[dayIndex].replaceAll('\n', ' ');
    _collectionTime = collectionTimes[timeIndex];
    notifyListeners();
  }

  // Set delivery schedule
  void setDeliverySchedule(int dayIndex, int timeIndex) {
    _selectedDeliveryDayIndex = dayIndex;
    _selectedDeliveryTimeIndex = timeIndex;
    _deliveryDate = deliveryDays[dayIndex].replaceAll('\n', ' ');
    _deliveryTime = deliveryTimes[timeIndex];
    notifyListeners();
  }

  // Set delivery type
  void setDeliveryType(String type) {
    _deliveryType = type;
    notifyListeners();
  }

  // Set collection instruction
  void setCollectionInstruction(String instruction) {
    _collectionInstruction = instruction;
    notifyListeners();
  }

  // Set delivery instruction
  void setDeliveryInstruction(String instruction) {
    _deliveryInstruction = instruction;
    notifyListeners();
  }

  // Validation
  bool canProceed() {
    return _selectedAddress != null &&
        _collectionDate != null &&
        _collectionTime != null &&
        _deliveryDate != null &&
        _deliveryTime != null;
  }

  // Get all data as Map
  Map<String, dynamic> getOrderDetailsMap() {
    return {
      'address': _selectedAddress,
      'collectionDate': _collectionDate,
      'collectionTime': _collectionTime,
      'deliveryDate': _deliveryDate,
      'deliveryTime': _deliveryTime,
      'deliveryType': _deliveryType,
      'collectionInstruction': _collectionInstruction,
      'deliveryInstruction': _deliveryInstruction,
    };
  }

  // Reset all
  void reset() {
    _selectedAddress = null;
    _collectionDate = null;
    _collectionTime = null;
    _deliveryDate = null;
    _deliveryTime = null;
    _deliveryType = 'door';
    _collectionInstruction = 'no_preference';
    _deliveryInstruction = 'no_preference';
    _selectedCollectionDayIndex = -1;
    _selectedCollectionTimeIndex = -1;
    _selectedDeliveryDayIndex = -1;
    _selectedDeliveryTimeIndex = -1;
    notifyListeners();
  }
}