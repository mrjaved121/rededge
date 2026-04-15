import 'package:flutter/material.dart';

class ScheduleProvider with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  DateTime _previousDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  DateTime get selectedDate => _selectedDate;
  DateTime get previousDate => _previousDate;
  TimeOfDay get selectedTime => _selectedTime;

  void updateDate(DateTime date) {
    _previousDate = _selectedDate;
    _selectedDate = date;
    notifyListeners();
  }

  void updateTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
  }

  DateTime get estimatedArrival {
    final dt = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    return dt.add(const Duration(minutes: 99));
  }
}
