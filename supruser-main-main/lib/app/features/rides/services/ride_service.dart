import 'package:suprapp/app/core/network/http_service.dart';
import 'package:suprapp/app/core/network/api_constants.dart';
import '../model/ride_order.dart';
import '../model/vehicle_type.dart';
import '../model/driver.dart';

class RideService {
  final _http = HttpService.instance;

  // Get vehicle types with pricing
  Future<List<VehicleType>> getVehicleTypesWithPricing({
    required double pickupLat,
    required double pickupLng,
    required double dropoffLat,
    required double dropoffLng,
  }) async {
    try {
      final response = await _http.get(
        ApiConstants.vehicleTypePricing,
        queryParameters: {
          'pickup': '$pickupLat,$pickupLng',
          'dropoff': '$dropoffLat,$dropoffLng',
        },
      );

      return (response.data as List)
          .map((e) => VehicleType.fromJson(e))
          .toList();
    } catch (e) {
      throw 'Failed to fetch vehicle types: $e';
    }
  }

  // Book a ride
  Future<RideOrder> bookRide({
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
    try {
      final response = await _http.post(
        ApiConstants.newTaxiBooking,
        {
          'vehicle_type_id': vehicleTypeId,
          'payment_method_id': paymentMethodId,
          'pickup': pickup,
          'dropoff': dropoff,
          'total': total,
          'discount': discount ?? 0,
          'coupon_code': couponCode,
          'pickup_date': pickupDate?.toIso8601String(),
          'pickup_time': pickupTime,
        },
      );

      return RideOrder.fromJson(response.data['order']);
    } catch (e) {
      throw 'Failed to book ride: $e';
    }
  }

  // Get current ongoing ride
  Future<RideOrder?> getCurrentRide() async {
    try {
      final response = await _http.get(ApiConstants.currentTaxiBooking);

      if (response.data['order'] != null) {
        return RideOrder.fromJson(response.data['order']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Cancel ride
  Future<bool> cancelRide(int orderId) async {
    try {
      await _http.get('${ApiConstants.cancelTaxiBooking}/$orderId');
      return true;
    } catch (e) {
      throw 'Failed to cancel ride: $e';
    }
  }

  // Get driver info
  Future<Driver> getDriverInfo(int driverId) async {
    try {
      final response = await _http.get('${ApiConstants.taxiDriverInfo}/$driverId');
      return Driver.fromJson(response.data['driver']);
    } catch (e) {
      throw 'Failed to get driver info: $e';
    }
  }

  // Rate driver
  Future<bool> rateDriver({
    required int orderId,
    required int driverId,
    required double rating,
    String? review,
  }) async {
    try {
      await _http.post(ApiConstants.rating, {
        'order_id': orderId,
        'driver_id': driverId,
        'rating': rating,
        'review': review ?? '',
      });
      return true;
    } catch (e) {
      throw 'Failed to rate driver: $e';
    }
  }
}