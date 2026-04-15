import 'dart:async';
import 'package:flutter/material.dart';

class OTPProvider extends ChangeNotifier {
  int currentField = 0;
  int secondsRemaining = 120;
  Timer? _timer;

  void startTimer() {
    secondsRemaining = 120;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
      } else {
        secondsRemaining--;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void moveFocus(int index, bool forward) {
    currentField = forward ? index + 1 : index - 1;
    if (currentField < 0) currentField = 0;
    if (currentField > 3) currentField = 3;
    notifyListeners();
  }

  String get formattedTime {
    final minutes = (secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void reset() {
    secondsRemaining = 120;
    currentField = 0;
    startTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
