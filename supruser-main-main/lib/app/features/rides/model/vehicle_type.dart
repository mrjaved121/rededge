// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// enum VehicleCategory {
//   bike,
//   economy,
//   comfort,
//   premium,
//   suv,
//   delivery
// }
//
// class VehicleType {
//   final int id;
//   final String name;
//   final String? slug;
//   final VehicleCategory category; // ADD THIS
//   final double baseFare;
//   final double distanceFare;
//   final double timeFare;
//   final double minFare;
//   final double total;
//   final double tax;
//   final String? photo;
//   final String? icon;
//   final int seater;
//   final double? surgeRate;
//   final int? estimatedTime; // ADD: ETA in minutes
//
//   VehicleType({
//     required this.id,
//     required this.name,
//     this.slug,
//     required this.category,
//     required this.baseFare,
//     required this.distanceFare,
//     required this.timeFare,
//     required this.minFare,
//     required this.total,
//     required this.tax,
//     this.photo,
//     this.icon,
//     required this.seater,
//     this.surgeRate,
//     this.estimatedTime,
//   });
//
//   factory VehicleType.fromJson(Map<String, dynamic> json) {
//     return VehicleType(
//       id: json['id'],
//       name: json['name'],
//       slug: json['slug'],
//       category: _getCategoryFromString(json['category'] ?? json['type'] ?? 'economy'),
//       baseFare: (json['base_fare'] ?? 0).toDouble(),
//       distanceFare: (json['distance_fare'] ?? 0).toDouble(),
//       timeFare: (json['time_fare'] ?? 0).toDouble(),
//       minFare: (json['min_fare'] ?? 0).toDouble(),
//       total: (json['total'] ?? 0).toDouble(),
//       tax: (json['tax'] ?? 0).toDouble(),
//       photo: json['photo'],
//       icon: json['icon'],
//       seater: json['seater'] ?? 4,
//       surgeRate: json['surge_rate']?.toDouble(),
//       estimatedTime: json['estimated_time'],
//     );
//   }
//
//   static VehicleCategory _getCategoryFromString(String category) {
//     switch (category.toLowerCase()) {
//       case 'bike':
//       case 'motorcycle':
//         return VehicleCategory.bike;
//       case 'economy':
//       case 'mini':
//         return VehicleCategory.economy;
//       case 'comfort':
//       case 'sedan':
//         return VehicleCategory.comfort;
//       case 'premium':
//       case 'luxury':
//         return VehicleCategory.premium;
//       case 'suv':
//       case 'xl':
//         return VehicleCategory.suv;
//       case 'delivery':
//         return VehicleCategory.delivery;
//       default:
//         return VehicleCategory.economy;
//     }
//   }
//
//   bool get isBike => category == VehicleCategory.bike;
//   bool get hasSurge => surgeRate != null && surgeRate! > 0;
//
//   IconData get vehicleIcon {
//     switch (category) {
//       case VehicleCategory.bike:
//         return Icons.two_wheeler;
//       case VehicleCategory.suv:
//         return Icons.airport_shuttle;
//       case VehicleCategory.premium:
//         return Icons.star;
//       case VehicleCategory.delivery:
//         return Icons.local_shipping;
//       default:
//         return Icons.directions_car;
//     }
//   }
// }


class VehicleType {
  final int id;
  final String name;
  final String? slug;
  final double baseFare;
  final double distanceFare;
  final double timeFare;
  final double minFare;
  final double total;
  final double tax;
  final String? photo;
  final String? icon;
  final int seater;
  final double? surgeRate;

  VehicleType({
    required this.id,
    required this.name,
    this.slug,
    required this.baseFare,
    required this.distanceFare,
    required this.timeFare,
    required this.minFare,
    required this.total,
    required this.tax,
    this.photo,
    this.icon,
    required this.seater,
    this.surgeRate,
  });

  factory VehicleType.fromJson(Map<String, dynamic> json) {
    return VehicleType(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      baseFare: (json['base_fare'] ?? 0).toDouble(),
      distanceFare: (json['distance_fare'] ?? 0).toDouble(),
      timeFare: (json['time_fare'] ?? 0).toDouble(),
      minFare: (json['min_fare'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      photo: json['photo'],
      icon: json['icon'],
      seater: json['seater'] ?? 4,
      surgeRate: json['surge_rate']?.toDouble(),
    );
  }

  bool get hasSurge => surgeRate != null && surgeRate! > 0;
}