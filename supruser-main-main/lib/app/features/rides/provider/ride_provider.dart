import 'package:flutter/material.dart';
import 'package:suprapp/app/features/rides/services/ride_service.dart';
import 'package:suprapp/app/features/rides/model/ride_order.dart';
import 'package:suprapp/app/features/rides/model/driver.dart';
import 'package:suprapp/app/features/rides/model/vehicle_type.dart';

class RideProvider with ChangeNotifier {
  final RideService _rideService = RideService();
  
  RideOrder? _currentRide;
  List<VehicleType> _vehicleTypes = [];
  Driver? _driver;

  bool _isLoading = false;
  String? _error;

  // Getters
  RideOrder? get currentRide => _currentRide;
  List<VehicleType> get vehicleTypes => _vehicleTypes;
  Driver? get driver => _driver;

  bool get isLoading => _isLoading;
  String? get error => _error;

  // Book a ride
  Future<void> bookRide({
    required int vehicleTypeId,
    required int paymentMethodId,
    required Map<String, dynamic> pickup,
    required Map<String, dynamic> dropoff,
    required double total,
    double? discount,
    String? couponCode,
    DateTime? pickupDate,
    String? pickupTime,
  }) async {
    _setLoading(true);
    try {
      _currentRide = await _rideService.bookRide(
        vehicleTypeId: vehicleTypeId,
        paymentMethodId: paymentMethodId,
        pickup: pickup,
        dropoff: dropoff,
        total: total,
        discount: discount,
        couponCode: couponCode,
        pickupDate: pickupDate,
        pickupTime: pickupTime,
      );
      _setError(null);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Accept a ride (for drivers)
  Future<void> acceptRide({
    required int orderId,
    required int driverId,
  }) async {
    _setLoading(true);
    try {
      _currentRide = await _rideService.acceptRide(
        orderId: orderId,
        driverId: driverId,
      );
      _setError(null);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Start a ride
  Future<void> startRide({
    required int orderId,
  }) async {
    _setLoading(true);
    try {
      _currentRide = await _rideService.startRide(orderId: orderId);
      _setError(null);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Complete a ride
  Future<void> completeRide({
    required int orderId,
  }) async {
    _setLoading(true);
    try {
      _currentRide = await _rideService.completeRide(orderId: orderId);
      _setError(null);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Get current ride
  Future<void> getCurrentRide() async {
    _setLoading(true);
    try {
      _currentRide = await _rideService.getCurrentRide();
      _setError(null);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Cancel a ride
  Future<void> cancelRide(int orderId) async {
    _setLoading(true);
    try {
      final success = await _rideService.cancelRide(orderId);
      if (success) {
        _currentRide = null;
        _setError(null);
        notifyListeners();
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Get driver info
  Future<void> getDriverInfo(int driverId) async {
    _setLoading(true);
    try {
      _driver = await _rideService.getDriverInfo(driverId);
      _setError(null);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Update driver location
  Future<void> updateDriverLocation({
    required int driverId,
    required double latitude,
    required double longitude,
  }) async {
    _setLoading(true);
    try {
      _driver = await _rideService.updateDriverLocation(
        driverId: driverId,
        latitude: latitude,
        longitude: longitude,
      );
      _setError(null);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Update driver status
  Future<void> updateDriverStatus({
    required int driverId,
    required String status,
  }) async {
    _setLoading(true);
    try {
      _driver = await _rideService.updateDriverStatus(
        driverId: driverId,
        status: status,
      );
      _setError(null);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }


  // Get vehicle types with pricing
  Future<void> getVehicleTypesWithPricing({
    required double pickupLat,
    required double pickupLng,
    required double dropoffLat,
    required double dropoffLng,
  }) async {
    _setLoading(true);
    try {
      _vehicleTypes = await _rideService.getVehicleTypesWithPricing(
        pickupLat: pickupLat,
        pickupLng: pickupLng,
        dropoffLat: dropoffLat,
        dropoffLng: dropoffLng,
      );
      _setError(null);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Rate driver
  Future<void> rateDriver({
    required int orderId,
    required int driverId,
    required double rating,
    String? review,
  }) async {
    _setLoading(true);
    try {
      final success = await _rideService.rateDriver(
        orderId: orderId,
        driverId: driverId,
        rating: rating,
        review: review,
      );
      if (success) {
        _setError(null);
        notifyListeners();
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Private methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _setError(null);
  }
}