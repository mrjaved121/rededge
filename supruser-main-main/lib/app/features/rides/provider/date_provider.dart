import 'package:flutter/material.dart';

class PickupTimeProvider extends ChangeNotifier {
  String? selectedDay;
  String? selectedTimeRange;
  String? selectedPeriod; // AM / PM

  void setPickupTime(String day, String timeRange, String period) {
    selectedDay = day;
    selectedTimeRange = timeRange;
    selectedPeriod = period;
    notifyListeners();
  }

  String get displayTime => '$selectedDay, $selectedTimeRange $selectedPeriod';
}
