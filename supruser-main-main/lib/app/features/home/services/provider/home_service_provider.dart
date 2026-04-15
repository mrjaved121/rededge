import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:suprapp/app/core/network/http_service.dart';
import 'package:suprapp/app/core/network/api_constants.dart';
import 'package:suprapp/app/features/home/services/models/home_service_models.dart';

class HomeServiceProvider extends ChangeNotifier {
  final _http = HttpService.instance;
  List<HomeServiceType> _serviceTypes = [];
  List<HomeServiceOrder> _userOrders = [];
  List<HomeServiceProfessional> _professionals = [];
  User? _currentUser;
  List<Coupon> _coupons = [];
  bool _isLoading = false;
  String? _error;

  List<HomeServiceType> get serviceTypes => _serviceTypes;
  List<HomeServiceOrder> get userOrders => _userOrders;
  List<HomeServiceProfessional> get professionals => _professionals;
  User? get currentUser => _currentUser;
  List<Coupon> get coupons => _coupons;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch all home service types
  Future<void> fetchServiceTypes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _http.get('${ApiConstants.baseUrl}/api/v1/home-services/types');

      if (response.statusCode == 200) {
        final data = json.decode(response.data.toString());
        final List<dynamic> typesData = data['data'];
        _serviceTypes = typesData
            .map((item) => HomeServiceType.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        _error = 'Failed to load service types';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch current user information
  Future<void> fetchCurrentUser() async {
    // In a real app, this would fetch from an API
    // For now, we'll create a mock user
    _currentUser = User(
      id: 1,
      name: "John Doe",
      phone: "+1234567890",
      createdAt: DateTime.now(),
      isLoyaltyMember: true, // Mock loyalty member
      loyaltyPoints: 150, // Mock loyalty points
    );
    notifyListeners();
  }

  // Fetch available coupons
  Future<void> fetchCoupons() async {
    // In a real app, this would fetch from an API
    // For now, we'll create mock coupons
    _coupons = [
      Coupon(
        id: 1,
        code: "LOYALTY10",
        description: "10% off for loyalty members",
        discount: 10.0,
        maxDiscount: 100.0,
        minOrder: 50.0,
        expiryDate: DateTime.now().add(Duration(days: 30)),
        isActive: true,
        createdAt: DateTime.now(),
      ),
      Coupon(
        id: 2,
        code: "WELCOME20",
        description: "20% off first service",
        discount: 20.0,
        maxDiscount: 150.0,
        minOrder: 100.0,
        expiryDate: DateTime.now().add(Duration(days: 7)),
        isActive: true,
        createdAt: DateTime.now(),
      ),
    ];
    notifyListeners();
  }

  // Calculate discount based on user loyalty status
  double calculateLoyaltyDiscount(double baseFare) {
    if (_currentUser != null && _currentUser!.isLoyaltyMember) {
      // Loyalty members get 10% discount
      return baseFare * 0.10;
    }
    return 0.0;
  }

  // Book a home service
  Future<HomeServiceOrder?> bookHomeService({
    required int userId,
    required String serviceType,
    required String pickupAddress,
    required double pickupLatitude,
    required double pickupLongitude,
    required DateTime serviceDate,
    required String serviceTime,
    required int duration,
    String? couponCode,
    // Specialty cleaning specific fields
    String? furnitureType,
    int? acUnitCount,
    // Packing/moving specific fields
    String? inventoryList,
    String? destinationAddress,
    // Medical services specific fields
    String? testType,
    String? medicalNotes,
    // Salon/spa services specific fields
    String? serviceCategory,
    // Laundry services specific fields
    String? clothingItems,
    String? pickupNotes,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _http.post(
        '${ApiConstants.baseUrl}/api/v1/home-services/book',
        {
          'user_id': userId,
          'service_type': serviceType,
          'pickup_address': pickupAddress,
          'pickup_latitude': pickupLatitude,
          'pickup_longitude': pickupLongitude,
          'service_date': serviceDate.toIso8601String().split('T')[0],
          'service_time': serviceTime,
          'duration': duration,
          'coupon_code': couponCode,
          // Specialty cleaning specific fields
          'furniture_type': furnitureType,
          'ac_unit_count': acUnitCount,
          // Packing/moving specific fields
          'inventory_list': inventoryList,
          'destination_address': destinationAddress,
          // Medical services specific fields
          'test_type': testType,
          'medical_notes': medicalNotes,
          // Salon/spa services specific fields
          'service_category': serviceCategory,
          // Laundry services specific fields
          'clothing_items': clothingItems,
          'pickup_notes': pickupNotes,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final orderData = data['data'] as Map<String, dynamic>;
        final order = HomeServiceOrder.fromJson(orderData);
        _userOrders.add(order);
        notifyListeners();
        return order;
      } else {
        _error = 'Failed to book service';
        notifyListeners();
        return null;
      }
    } catch (e) {
      _error = 'Error: $e';
      notifyListeners();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch user's home service orders
  Future<void> fetchUserOrders(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _http.get('${ApiConstants.baseUrl}/api/v1/home-services/user/$userId');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List<dynamic> ordersData = data['data'];
        _userOrders = ordersData
            .map((item) => HomeServiceOrder.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        _error = 'Failed to load user orders';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch available professionals
  Future<void> fetchAvailableProfessionals({String? serviceType}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final uri = serviceType != null
          ? '${ApiConstants.baseUrl}/api/v1/home-services/professionals?service_type=$serviceType'
          : '${ApiConstants.baseUrl}/api/v1/home-services/professionals';

      final response = await _http.get(uri);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List<dynamic> prosData = data['data'];
        _professionals = prosData
            .map((item) => HomeServiceProfessional.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        _error = 'Failed to load professionals';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Cancel a home service order
  Future<bool> cancelOrder(int orderId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _http.get('${ApiConstants.baseUrl}/api/v1/home-services/cancel/$orderId');

      if (response.statusCode == 200) {
        // Update the order status in the list
        final orderIndex = _userOrders.indexWhere((order) => order.id == orderId);
        if (orderIndex != -1) {
          _userOrders[orderIndex] = HomeServiceOrder(
            id: _userOrders[orderIndex].id,
            userId: _userOrders[orderIndex].userId,
            serviceType: _userOrders[orderIndex].serviceType,
            pickupAddress: _userOrders[orderIndex].pickupAddress,
            pickupLatitude: _userOrders[orderIndex].pickupLatitude,
            pickupLongitude: _userOrders[orderIndex].pickupLongitude,
            serviceDate: _userOrders[orderIndex].serviceDate,
            serviceTime: _userOrders[orderIndex].serviceTime,
            duration: _userOrders[orderIndex].duration,
            status: 'cancelled',
            totalAmount: _userOrders[orderIndex].totalAmount,
            createdAt: _userOrders[orderIndex].createdAt,
          );
          notifyListeners();
        }
        return true;
      } else {
        _error = 'Failed to cancel order';
        return false;
      }
    } catch (e) {
      _error = 'Error: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}