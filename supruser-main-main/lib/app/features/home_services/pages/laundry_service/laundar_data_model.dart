import 'package:flutter/material.dart';

class LaundryService {
  final String id;
  final String name;
  final String icon;
  final Color color;

  LaundryService({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class LaundryItem {
  final String id;
  final String name;
  final double price;
  final double originalPrice;
  final String? category;

  LaundryItem({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    this.category,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LaundryItem &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class LaundryPackage {
  final String id;
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final String? imageUrl;
  final List<String> features;
  final String? serviceType; // 'bed_bath', 'wash_fold', etc.

  LaundryPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.originalPrice,
    this.imageUrl,
    required this.features,
    this.serviceType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LaundryPackage &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}

