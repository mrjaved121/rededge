import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';
import '../models/brand_model.dart';

class ElectronicsController extends ChangeNotifier {
  // Sample Apple Products
  final List<ProductModel> appleProducts = [
    ProductModel(
      id: '1',
      title: 'Apple iPhone 17 Pro 512GB Cosmi...',
      image: 'assets/images/iphonefull.png',
      originalPrice: '₱ 5,549',
      discountedPrice: '₱ 5,327.05',
      discount: '4% off',
      category: ProductCategory.mobile,
    ),
    ProductModel(
      id: '2',
      title: 'Apple iPhone Air 256GB Sky Blue -...',
      image: 'assets/images/iphone.png',
      originalPrice: '₱ 4,299',
      discountedPrice: '₱ 4,127.05',
      discount: '4% off',
      category: ProductCategory.mobile,
    ),
    ProductModel(
      id: '3',
      title: 'Apple iPhone 17 512GB Sky Bl...',
      image: 'assets/images/iphonefull.png',
      originalPrice: '₱ 5,149',
      discountedPrice: '₱ 4,943.05',
      discount: '4% off',
      category: ProductCategory.mobile,
    ),
  ];

  // Sample Bestselling Products
  final List<ProductModel> bestsellingProducts = [
    ProductModel(
      id: '4',
      title: 'Samsung S24 Plus (12GB 256GB) On...',
      image: 'assets/images/iphonefull.png',
      originalPrice: '₱ 3,876',
      discountedPrice: '₱ 2,984.55',
      discount: '23% off',
      category: ProductCategory.mobile,
    ),
    ProductModel(
      id: '5',
      title: 'Samsung Z Flip 6 - 12GB 512GB Yello...',
      image: 'assets/images/iphone16.png',
      originalPrice: '₱ 4,799',
      discountedPrice: '₱ 3,167.35',
      discount: '34% off',
      category: ProductCategory.mobile,
    ),
    ProductModel(
      id: '6',
      title: 'Samsung Galaxy Z Flip 6 - 12GB',
      image: 'assets/images/iphonefull.png',
      originalPrice: '₱ 4,799',
      discountedPrice: '₱ 3,167.35',
      discount: '34% off',
      category: ProductCategory.mobile,
    ),
  ];

  // Sample Nutricook Products
  final List<ProductModel> nutricookProducts = [
    ProductModel(
      id: '7',
      title: 'Nutricook Toasti Digital Toaster 2...',
      image: 'assets/images/airfresher.png',
      originalPrice: '₱ 199',
      discountedPrice: '₱ 169.15',
      discount: '15% off',
      category: ProductCategory.appliance,
    ),
    ProductModel(
      id: '8',
      title: 'Nutribullet Full Size Blender + Co...',
      image: 'assets/images/airfresher.png',
      originalPrice: '₱ 449',
      discountedPrice: '₱ 404.10',
      discount: '10% off',
      category: ProductCategory.appliance,
    ),
    ProductModel(
      id: '9',
      title: 'Nutricook Multi Purpose 500',
      image: 'assets/images/airfresher.png',
      originalPrice: '₱ 155',
      discountedPrice: '₱ 93.85',
      discount: '41% off',
      category: ProductCategory.appliance,
    ),
  ];

  // Sample Accessories
  final List<ProductModel> accessoryProducts = [
    ProductModel(
      id: '10',
      title: 'Apple AirPods 4 Wireless Earbuds...',
      image: 'assets/images/adapter.png',
      originalPrice: '₱ 499',
      discountedPrice: '₱ 394.25',
      discount: '21% off',
      category: ProductCategory.accessory,
    ),
    ProductModel(
      id: '11',
      title: 'Universal World Travel Adapter 12...',
      image: 'assets/images/adapter.png',
      originalPrice: '₱ 79',
      discountedPrice: '₱ 26.90',
      discount: '66% off',
      category: ProductCategory.accessory,
    ),
    ProductModel(
      id: '12',
      title: 'Honeywell Zen Charger GaN',
      image: 'assets/images/adapter.png',
      originalPrice: '₱ 179',
      discountedPrice: '₱ 112.80',
      discount: '37% off',
      category: ProductCategory.accessory,
    ),
  ];

  // Sample Gaming Products
  final List<ProductModel> gamingProducts = [
    ProductModel(
      id: '13',
      title: 'Nintendo Switch 2 + Mario Kart Bun...',
      image: 'assets/images/game.png',
      originalPrice: '₱ 2,879',
      discountedPrice: '₱ 2,044.10',
      discount: '29% off',
      category: ProductCategory.gaming,
    ),
    ProductModel(
      id: '14',
      title: 'Nintendo Switch 2 Console',
      image: 'assets/images/game.png',
      originalPrice: '₱ 2,599',
      discountedPrice: '₱ 1,689.35',
      discount: '35% off',
      category: ProductCategory.gaming,
    ),
    ProductModel(
      id: '15',
      title: 'Logitech G Pro Superlight 2',
      image: 'assets/images/game.png',
      originalPrice: '₱ 669',
      discountedPrice: '₱ 501.75',
      discount: '25% off',
      category: ProductCategory.gaming,
    ),
  ];

  // Sample Tablets
  final List<ProductModel> tabletProducts = [
    ProductModel(
      id: '16',
      title: 'Samsung Tab A9 Plus Silver 8GB 12...',
      image: 'assets/images/tab.png',
      originalPrice: '₱ 749',
      discountedPrice: '₱ 599.20',
      discount: '20% off',
      category: ProductCategory.tablet,
    ),
    ProductModel(
      id: '17',
      title: 'Apple iPad Mini 2024 7th Gen 8.3...',
      image: 'assets/images/tab.png',
      originalPrice: '₱ 1,949',
      discountedPrice: '₱ 1,715.15',
      discount: '12% off',
      category: ProductCategory.tablet,
    ),
    ProductModel(
      id: '18',
      title: 'iPad Air 2025 13-Inch Wi-Fi',
      image: 'assets/images/tab.png',
      originalPrice: '₱ 3,899',
      discountedPrice: '₱ 3,743.05',
      discount: '4% off',
      category: ProductCategory.tablet,
    ),
  ];

  // Sample Personal Care
  final List<ProductModel> personalCareProducts = [
    ProductModel(
      id: '19',
      title: 'Dyson Airstrait Straightener - Re...',
      image: 'assets/images/personcare.png',
      originalPrice: '₱ 1,999',
      discountedPrice: '₱ 1,759.15',
      discount: '12% off',
      category: ProductCategory.personalCare,
    ),
    ProductModel(
      id: '20',
      title: 'Dyson Airwrap i.d. Multi-Styler & Dr...',
      image: 'assets/images/personcare.png',
      discountedPrice: '₱ 2,299',
      category: ProductCategory.personalCare,
    ),
    ProductModel(
      id: '21',
      title: 'Theragun Sense Black',
      image: 'assets/images/personcare.png',
      originalPrice: '₱ 1,349',
      discountedPrice: '₱ 1,092.70',
      discount: '19% off',
      category: ProductCategory.personalCare,
    ),
  ];

  // Sample Laptops
  final List<ProductModel> laptopProducts = [
    ProductModel(
      id: '22',
      title: 'MacBook Air 13 Inch -',
      image: 'assets/images/laptop.png',
      discountedPrice: '₱ 3,999',
      category: ProductCategory.laptop,
    ),
    ProductModel(
      id: '23',
      title: 'MacBook Air 13 Inch - ',
      image: 'assets/images/laptop.png',
      discountedPrice: '₱ 3,999',
      category: ProductCategory.laptop,
    ),
  ];

  // Categories
  final List<CategoryModel> categories = [
    CategoryModel(id: '1', name: 'Mobiles', image: 'assets/images/vivo.png'),
    CategoryModel(id: '2', name: 'Mobiles\naccessories', image: 'assets/images/controller.png'),
    CategoryModel(id: '3', name: 'Tablets', image: 'assets/images/tab.png'),
    CategoryModel(id: '4', name: 'Laptops', image: 'assets/images/laptop.png'),
    CategoryModel(id: '5', name: 'Gaming', image: 'assets/images/controller.png'),
    CategoryModel(id: '6', name: 'Wearables', image: 'assets/images/controller.png'),
    CategoryModel(id: '7', name: 'Personal\ncare', image: 'assets/images/controller.png'),
    CategoryModel(id: '8', name: 'Computer\naccessories', image: 'assets/images/controller.png'),
  ];

  // Brands
  final List<BrandModel> brands = [
    BrandModel(id: '1', name: 'Apple', offer: 'Up to 60% off', icon: Icons.apple),
    BrandModel(id: '2', name: 'SONY', offer: 'Up to 40% off'),
    BrandModel(id: '3', name: 'Marshall', offer: 'Up to 15% off'),
    BrandModel(id: '4', name: 'SAMSUNG', offer: 'Up to 50% off'),
    BrandModel(id: '5', name: 'dyson', offer: 'Shop now'),
    BrandModel(id: '6', name: 'JBL', offer: 'Up to 10% off'),
  ];

  void addToCart(ProductModel product) {
    // Add to cart logic
    notifyListeners();
  }
}