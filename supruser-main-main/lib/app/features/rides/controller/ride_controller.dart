import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:suprapp/app/features/rides/model/ride_order.dart';
import 'package:suprapp/app/features/rides/model/vehicle_type.dart';
import 'package:suprapp/app/features/rides/services/ride_service.dart';
import 'package:suprapp/app/features/rides/services/ride_websocket_service.dart';

class RideController extends ChangeNotifier {
  final RideService _rideService = RideService();
  final RideWebSocketService _wsService = RideWebSocketService();

  // States
  bool _isLoading = false;
  String? _error;

  // Location data
  LatLng? _pickupLocation;
  LatLng? _dropoffLocation;
  String? _pickupAddress;
  String? _dropoffAddress;

  // Vehicle types
  List<VehicleType> _vehicleTypes = [];
  VehicleType? _selectedVehicleType;

  // Current ride
  RideOrder? _currentRide;

  // Pricing
  double _estimatedFare = 0.0;
  double _discount = 0.0;
  double _finalFare = 0.0;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  LatLng? get pickupLocation => _pickupLocation;
  LatLng? get dropoffLocation => _dropoffLocation;
  String? get pickupAddress => _pickupAddress;
  String? get dropoffAddress => _dropoffAddress;
  List<VehicleType> get vehicleTypes => _vehicleTypes;
  VehicleType? get selectedVehicleType => _selectedVehicleType;
  RideOrder? get currentRide => _currentRide;
  double get estimatedFare => _estimatedFare;
  double get finalFare => _finalFare;

  // Initialize
  Future<void> initialize() async {
    await checkForCurrentRide();
  }

  // Set pickup location
  void setPickupLocation(LatLng location, String address) {
    _pickupLocation = location;
    _pickupAddress = address;
    notifyListeners();

    if (_dropoffLocation != null) {
      fetchVehicleTypes();
    }
  }

  // Set dropoff location
  void setDropoffLocation(LatLng location, String address) {
    _dropoffLocation = location;
    _dropoffAddress = address;
    notifyListeners();

    if (_pickupLocation != null) {
      fetchVehicleTypes();
    }
  }

  // Fetch vehicle types with pricing
  Future<void> fetchVehicleTypes() async {
    if (_pickupLocation == null || _dropoffLocation == null) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _vehicleTypes = await _rideService.getVehicleTypesWithPricing(
        pickupLat: _pickupLocation!.latitude,
        pickupLng: _pickupLocation!.longitude,
        dropoffLat: _dropoffLocation!.latitude,
        dropoffLng: _dropoffLocation!.longitude,
      );

      if (_vehicleTypes.isNotEmpty) {
        selectVehicleType(_vehicleTypes.first);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Select vehicle type
  void selectVehicleType(VehicleType vehicleType) {
    _selectedVehicleType = vehicleType;
    _estimatedFare = vehicleType.total;
    calculateFinalFare();
    notifyListeners();
  }

  // Calculate final fare
  void calculateFinalFare() {
    _finalFare = _estimatedFare - _discount;
    if (_selectedVehicleType != null) {
      _finalFare += _selectedVehicleType!.tax;
    }
    notifyListeners();
  }

  // Book ride
  Future<void> bookRide({int paymentMethodId = 1}) async {
    if (_pickupLocation == null ||
        _dropoffLocation == null ||
        _selectedVehicleType == null) {
      _error = 'Please select pickup, dropoff and vehicle type';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentRide = await _rideService.bookRide(
        vehicleTypeId: _selectedVehicleType!.id,
        paymentMethodId: paymentMethodId,
        pickup: {
          'lat': _pickupLocation!.latitude,
          'lng': _pickupLocation!.longitude,
          'address': _pickupAddress ?? '',
        },
        dropoff: {
          'lat': _dropoffLocation!.latitude,
          'lng': _dropoffLocation!.longitude,
          'address': _dropoffAddress ?? '',
        },
        total: _finalFare,
        discount: _discount,
      );

      // Start tracking ride
      if (_currentRide != null) {
        _startRideTracking();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Check for current ride
  Future<void> checkForCurrentRide() async {
    try {
      _currentRide = await _rideService.getCurrentRide();
      if (_currentRide != null) {
        _startRideTracking();
      }
      notifyListeners();
    } catch (e) {
      print('Error checking current ride: $e');
    }
  }

  // Start ride tracking
  void _startRideTracking() {
    if (_currentRide == null) return;

    _wsService.connectToRide(
      orderId: _currentRide!.id,
      onStatusUpdate: (status) {
        _currentRide = RideOrder(
          id: _currentRide!.id,
          code: _currentRide!.code,
          driverId: _currentRide!.driverId,
          status: status,
          pickupAddress: _currentRide!.pickupAddress,
          pickupLatitude: _currentRide!.pickupLatitude,
          pickupLongitude: _currentRide!.pickupLongitude,
          dropoffAddress: _currentRide!.dropoffAddress,
          dropoffLatitude: _currentRide!.dropoffLatitude,
          dropoffLongitude: _currentRide!.dropoffLongitude,
          vehicleType: _currentRide!.vehicleType,
          driver: _currentRide!.driver,
        );
        notifyListeners();
      },
      onDriverLocation: (lat, lng) {
        // Update driver marker on map
        notifyListeners();
      },
    );
  }

  // Cancel ride
  Future<void> cancelRide() async {
    if (_currentRide == null) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _rideService.cancelRide(_currentRide!.id);
      _currentRide = null;
      _wsService.disconnect();

      // Reset state
      _pickupLocation = null;
      _dropoffLocation = null;
      _pickupAddress = null;
      _dropoffAddress = null;
      _vehicleTypes = [];
      _selectedVehicleType = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Rate driver
  Future<void> rateDriver(double rating, String review) async {
    if (_currentRide?.driver == null) return;

    try {
      await _rideService.rateDriver(
        orderId: _currentRide!.id,
        driverId: _currentRide!.driver!.id,
        rating: rating,
        review: review,
      );

      _currentRide = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _wsService.disconnect();
    super.dispose();
  }
}