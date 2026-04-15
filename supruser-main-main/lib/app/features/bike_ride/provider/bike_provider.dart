import 'package:flutter/foundation.dart';
import 'package:suprapp/app/features/bike_ride/model/bike_model.dart';

class BikeProvider with ChangeNotifier {
  BikeModel? _selectedBike;

  BikeModel? get selectedBike => _selectedBike;

  void selectBike(BikeModel bikes) {
    _selectedBike = bikes;

    bike.remove(bike);
    bike.insert(0, bikes);

    notifyListeners();
  }
}
