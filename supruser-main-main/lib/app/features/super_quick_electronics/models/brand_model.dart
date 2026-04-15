import 'package:flutter/material.dart';

class BrandModel {
  final String id;
  final String name;
  final String offer;
  final IconData? icon;

  BrandModel({
    required this.id,
    required this.name,
    required this.offer,
    this.icon,
  });
}