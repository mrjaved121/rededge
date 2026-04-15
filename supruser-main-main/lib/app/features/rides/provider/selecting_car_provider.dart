import 'package:flutter/foundation.dart';
import 'package:suprapp/app/features/rides/model/cars_model.dart';

class CarProvider with ChangeNotifier {
  CarsModel? _selectedCar;

  CarsModel? get selectedCar => _selectedCar;

  void selectCar(CarsModel car) {
    _selectedCar = car;

    // Move selected car to top
    cars.remove(car);
    cars.insert(0, car);

    notifyListeners();
  }
}
