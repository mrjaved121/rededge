// ====================== MODELS ======================
// File: servvices_datamodel.dart

import 'package:flutter/material.dart';

import '../pages/home_cleaning/provider/home_cleaing_provider.dart';

// ✅ 1. NEW: TabBanner class (for banner under each tab)
class TabBanner {
  final String title;
  final String description;
  final String? imageUrl;
  final IconData? icon;
  final Color? backgroundColor;

  TabBanner({
    required this.title,
    required this.description,
    this.imageUrl,
    this.icon,
    this.backgroundColor,
  });
}

// ✅ 2. Service class (NO CHANGES)
class Service {
  final String id;
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final String imageUrl;
  final String category;
  final String? tabCategory;
  final int maxQuantity;


  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.category,
    this.tabCategory,
    this.maxQuantity = 99,
  });
}

// ✅ 3. UPDATED: ServiceCategory class (added tabBanners field)
class ServiceCategory {
  final String id;
  final String name;
  final String description;
  final List<String> highlights;
  final String bannerImage;
  final String bannerDescription;
  final List<Service> services;
  final List<String> tabs;
  final Map<String, TabBanner>? tabBanners;
  final List<AddOnService>? addOns;

  ServiceCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.highlights,
    required this.bannerImage,
    required this.bannerDescription,
    required this.services,
    required this.tabs,
    this.tabBanners,
    this.addOns
  });
}