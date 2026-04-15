// ============= laundry_dummy_data.dart =============

import 'dart:ui';

import 'laundar_data_model.dart';

class LaundryDummyData {
  static List<LaundryService> getServices() {
    return [
      LaundryService(
        id: 'hang',
        name: 'Hang',
        icon: 'Icons.checkroom',
        color: Color(0xff00FF00),
      ),
      LaundryService(
        id: 'iron',
        name: 'Iron',
        icon: 'Icons.iron',
        color: Color(0xffc0c0c0),
      ),
      LaundryService(
        id: 'wash',
        name: 'Wash',
        icon: 'Icons.format_line_spacing',
        color: Color(0xffFF1493),
      ),
      LaundryService(
        id: 'temperature',
        name: '40°C',
        icon: 'Icons.thermostat',
        color: Color(0xff00BFFF),
      ),
      LaundryService(
        id: 'dry',
        name: 'Dry',
        icon: 'Icons.local_fire_department',
        color: Color(0xffFF8C00),
      ),
    ];
  }

  static List<LaundryItem> getTopsItems() {
    return [
      LaundryItem(
        id: 'shirt',
        name: 'Shirt',
        price: 13,
        originalPrice: 18,
        category: 'Tops',
      ),
      LaundryItem(
        id: 't_shirt',
        name: 'T Shirt',
        price: 18,
        originalPrice: 18,
        category: 'Tops',
      ),
      LaundryItem(
        id: 'blouse',
        name: 'Blouse',
        price: 18,
        originalPrice: 18,
        category: 'Tops',
      ),
    ];
  }

  static List<LaundryItem> getBottomsItems() {
    return [
      LaundryItem(
        id: 'shorts',
        name: 'Shorts',
        price: 16,
        originalPrice: 16,
        category: 'Bottoms',
      ),
      LaundryItem(
        id: 'pants',
        name: 'Pants',
        price: 17,
        originalPrice: 17,
        category: 'Bottoms',
      ),
      LaundryItem(
        id: 'skirt',
        name: 'Skirt',
        price: 17,
        originalPrice: 17,
        category: 'Bottoms',
      ),
      LaundryItem(
        id: 'jeans',
        name: 'Jeans',
        price: 17,
        originalPrice: 17,
        category: 'Bottoms',
      ),
    ];
  }

  static List<LaundryPackage> getBedBathPackages() {
    return [
      LaundryPackage(
        id: 'bed_bath_basic',
        name: 'Bed & Bath',
        description: 'Clean & Press bag for your home linens',
        price: 66,
        originalPrice: 95,
        features: [
          'Up to 15 items',
          'Perfectly cleaned and pressed',
          'Free stain removal',
        ],
        serviceType: 'bed_bath',
      ),
    ];
  }

  static List<LaundryPackage> getWashFoldPackages() {
    return [
      LaundryPackage(
        id: 'wash_fold_basic',
        name: 'Fill it up',
        description: 'Equal to 3x washes at home',
        price: 55,
        originalPrice: 75,
        features: [
          'Up to 12 Kg laundry',
          'Equal to 3 full laundry loads',
          '40°C wash and tumble dry',
          'Pressing not included',
        ],
        serviceType: 'wash_fold',
      ),
    ];
  }

  static List<LaundryItem> getShoeItems() {
    return [
      LaundryItem(
        id: 'formal_shoe_polish',
        name: 'Formal Shoe Polishing',
        price: 75,
        originalPrice: 75,
        category: 'ShoeTypes',
      ),
      LaundryItem(
        id: 'sports_sneakers',
        name: 'Sports Sneakers',
        price: 95,
        originalPrice: 95,
        category: 'ShoeTypes',
      ),
      LaundryItem(
        id: 'designer_sneakers',
        name: 'Designer Sneakers',
        price: 145,
        originalPrice: 145,
        category: 'ShoeTypes',
      ),
      LaundryItem(
        id: 'formal_shoes',
        name: 'Formal Shoes',
        price: 110,
        originalPrice: 110,
        category: 'ShoeTypes',
      ),
      LaundryItem(
        id: 'sandals',
        name: 'Sandals',
        price: 85,
        originalPrice: 85,
        category: 'ShoeTypes',
      ),
    ];
  }

  static List<LaundryItem> getAddOnsItems() {
    return [
      LaundryItem(
        id: 'stain_protection',
        name: 'Stain Protection',
        price: 20,
        originalPrice: 20,
        category: 'AddOns',
      ),
      LaundryItem(
        id: 'icing_soles',
        name: 'Icing Soles',
        price: 35,
        originalPrice: 35,
        category: 'AddOns',
      ),
      LaundryItem(
        id: 'colour_touch_ups',
        name: 'Colour Touch-ups',
        price: 50,
        originalPrice: 50,
        category: 'AddOns',
      ),
    ];
  }

  static Map<String, List<LaundryItem>> getAllCategories() {
    return {
      'Tops': getTopsItems(),
      'Bottoms': getBottomsItems(),
      'Shoes': getShoeItems(),
      'AddOns': getAddOnsItems(),
    };
  }
}