import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'vehicle_type.dart';
import 'driver.dart';

class RideOrder {
  final int id;
  final String? code;
  final int? driverId;
  final String status;
  final String pickupAddress;
  final double pickupLatitude;
  final double pickupLongitude;
  final String dropoffAddress;
  final double dropoffLatitude;
  final double dropoffLongitude;
  final double? baseFare;
  final double? distanceFare;
  final double? timeFare;
  final double? total;
  final double? tax;
  final VehicleType? vehicleType;
  final Driver? driver;
  final DateTime? createdAt;
  final DateTime? pickupDate;
  final String? pickupTime;

  RideOrder({
    required this.id,
    this.code,
    this.driverId,
    required this.status,
    required this.pickupAddress,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.dropoffAddress,
    required this.dropoffLatitude,
    required this.dropoffLongitude,
    this.baseFare,
    this.distanceFare,
    this.timeFare,
    this.total,
    this.tax,
    this.vehicleType,
    this.driver,
    this.createdAt,
    this.pickupDate,
    this.pickupTime,
  });

  factory RideOrder.fromJson(Map<String, dynamic> json) {
    return RideOrder(
      id: json['id'],
      code: json['code'],
      driverId: json['driver_id'],
      status: json['status'] ?? 'pending',
      pickupAddress: json['pickup_address'] ?? '',
      pickupLatitude: double.parse(json['pickup_latitude'].toString()),
      pickupLongitude: double.parse(json['pickup_longitude'].toString()),
      dropoffAddress: json['dropoff_address'] ?? '',
      dropoffLatitude: double.parse(json['dropoff_latitude'].toString()),
      dropoffLongitude: double.parse(json['dropoff_longitude'].toString()),
      baseFare: json['base_fare']?.toDouble(),
      distanceFare: json['distance_fare']?.toDouble(),
      timeFare: json['time_fare']?.toDouble(),
      total: json['total']?.toDouble(),
      tax: json['tax']?.toDouble(),
      vehicleType: json['vehicle_type'] != null
          ? VehicleType.fromJson(json['vehicle_type'])
          : null,
      driver: json['driver'] != null
          ? Driver.fromJson(json['driver'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      pickupDate: json['pickup_date'] != null
          ? DateTime.parse(json['pickup_date'])
          : null,
      pickupTime: json['pickup_time'],
    );
  }

  LatLng get pickupLatLng => LatLng(pickupLatitude, pickupLongitude);
  LatLng get dropoffLatLng => LatLng(dropoffLatitude, dropoffLongitude);

  bool get isScheduled => pickupDate != null || pickupTime != null;
  bool get isPending => status == 'pending';
  bool get isAccepted => status == 'accepted' || status == 'preparing';
  bool get isEnroute => status == 'enroute';
  bool get isCompleted => status == 'delivered' || status == 'completed';
  bool get isCancelled => status == 'cancelled';
}