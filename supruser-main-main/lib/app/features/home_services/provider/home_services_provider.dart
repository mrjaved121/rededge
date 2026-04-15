import 'package:flutter/material.dart';
import '../../../core/constants/app_images.dart';
import '../model/offer_model.dart';
import '../model/service_model.dart';

class HomeServicesProvider extends ChangeNotifier {
  // Loading states
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Services data
  List<ServiceModel> _mainServices = [];
  List<ServiceModel> _allServices = [];
  List<OfferModel> _topOffers = [];

  List<ServiceModel> get mainServices => _mainServices;
  List<ServiceModel> get allServices => _allServices;
  List<OfferModel> get topOffers => _topOffers;

  // Selected service
  ServiceModel? _selectedService;
  ServiceModel? get selectedService => _selectedService;

  HomeServicesProvider() {
    _initializeData();
  }

  void _initializeData() {
    // Main Services (2 cards)
    _mainServices = [
      ServiceModel(
        id: '1',
        title: 'Home Cleaning',
        imagePath: AppIcon.homecleanigairbrush,
        hasOffer: false,
        serviceType: ServiceType.homeCleaning,
        description: 'Professional home cleaning services',
        features: ['Deep Cleaning', 'Regular Cleaning', 'Move-in/Move-out'],
      ),
      ServiceModel(
        id: '2',
        title: 'Laundry',
        imagePath: AppIcon.laundaryservice,
        hasOffer: true,
        offerText: 'AED300ff',
        serviceType: ServiceType.laundry,
        description: 'Premium laundry and dry cleaning services',
        features: ['Wash & Fold', 'Dry Cleaning', 'Ironing'],
      ),
    ];

    // All Services (8 cards)
    _allServices = [
      ServiceModel(
        id: '3',
        title: 'Salon & Spa',
        imagePath: AppIcon.salonspabgr,
        serviceType: ServiceType.salonSpa,
      ),
      ServiceModel(
        id: '4',
        title: 'Furniture\nCleaning',
        imagePath: AppIcon.salonspabgr,
        serviceType: ServiceType.furnitureCleaning,
      ),
      ServiceModel(
        id: '5',
        title: 'AC Cleaning',
        imagePath: AppIcon.salonspabgr,
        serviceType: ServiceType.acCleaning,
      ),
      ServiceModel(
        id: '6',
        title: 'IV Therapy',
        imagePath: AppIcon.salonspabgr,
        serviceType: ServiceType.ivTherapy,
      ),
      ServiceModel(
        id: '7',
        title: 'Lab Tests',
        imagePath: AppIcon.salonspabgr,
        serviceType: ServiceType.labTests,
      ),
      ServiceModel(
        id: '8',
        title: 'Deep\nCleaning',
        imagePath: AppIcon.salonspabgr,
        serviceType: ServiceType.deepCleaning,
      ),
      ServiceModel(
        id: '9',
        title: 'Pest Control',
        imagePath: AppIcon.salonspabgr,
        serviceType: ServiceType.pestControl,
      ),
      ServiceModel(
        id: '10',
        title: 'Packers &\nMovers',
        imagePath: AppIcon.salonspabgr,
        serviceType: ServiceType.packersMovers,
      ),
    ];

    // Top Offers
    _topOffers = [
      OfferModel(
        id: 'offer1',
        title: 'HomeCleaning',
        subtitle: 'Clean home,\nhappy you',
        code: 'Code: 50OFFER',
        discount: '৳ 50 off',
        backgroundColor: const Color(0xFF6366F1),
      ),
      OfferModel(
        id: 'offer2',
        title: 'Laundry',
        subtitle: 'Laundry,\ndone your w...',
        code: 'Code: CAREEM30',
        discount: '৳ 30 off',
        backgroundColor: const Color(0xFF14B8A6),
      ),
      OfferModel(
        id: 'offer3',
        title: 'Pest Control',
        subtitle: 'Safe home,\ntension free',
        code: 'Code: PEST20',
        discount: '৳ 20 off',
        backgroundColor: const Color(0xFF8B5CF6),
      ),
    ];
  }

  // 🆕 Navigation Helper - Get route for service type
  String getServiceRoute(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.homeCleaning:
        return '/home-cleaning';
      case ServiceType.laundry:
        return '/laundry-service';
      case ServiceType.salonSpa:
        return '/salon-spa';
      case ServiceType.furnitureCleaning:
        return '/furniture-cleaning';
      case ServiceType.acCleaning:
        return '/ac-cleaning';
      case ServiceType.ivTherapy:
        return '/iv-therapy';
      case ServiceType.labTests:
        return '/lab-tests';
      case ServiceType.deepCleaning:
        return '/deep-cleaning';
      case ServiceType.pestControl:
        return '/pest-control';
      case ServiceType.packersMovers:
        return '/packers-movers';
      default:
        return '/home-services';
    }
  }

  // Select a service
  void selectService(ServiceModel service) {
    _selectedService = service;
    notifyListeners();
  }

  // Load services from API
  Future<void> loadServices() async {
    _isLoading = true;
    notifyListeners();

    try {
      // API call simulation
      await Future.delayed(const Duration(seconds: 2));

      // Update services from API response
      // _mainServices = ...
      // _allServices = ...
      // _topOffers = ...

    } catch (e) {
      debugPrint('Error loading services: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Apply offer code
  Future<bool> applyOfferCode(String code) async {
    try {
      // Validate offer code
      await Future.delayed(const Duration(seconds: 1));

      // Return true if valid, false otherwise
      return true;
    } catch (e) {
      return false;
    }
  }

  // Clear selection
  void clearSelection() {
    _selectedService = null;
    notifyListeners();
  }
}