import 'package:flutter/material.dart';
import '../model/service_model.dart';
import '../splashscreen.dart'; // Aapka splash screen
import '../pages/home_cleaning/home_cleaning_page.dart';
import '../pages/laundry_service/laundry_home_page.dart';
import '../pages/salon_spa/salon_spa_page.dart';
import '../pages/furniture_cleaning/furniture_cleaning_page.dart';
import '../pages/ac_cleaning/ac_cleaning_page.dart';
import '../pages/iv_therapy/iv_therapy_page.dart';
import '../pages/labs_tests/lab_tests_page.dart';
import '../pages/deep_cleaning/deep_cleaning_page.dart';
import '../pages/pest_control/pest_control_page.dart';
import '../pages/packers_movers/packers_movers_page.dart';

class ServiceNavigationHelper {
  // Service type ke hisaab se target page
  static Widget getTargetPage(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.homeCleaning:
        return const HomeCleaningPage();
      case ServiceType.laundry:
        return const LaundryHomePage();
      case ServiceType.salonSpa:
        return const SalonSpaPage();
      case ServiceType.furnitureCleaning:
        return const FurnitureCleaningPage();
      case ServiceType.acCleaning:
        return const AcCleaningPage();
      case ServiceType.ivTherapy:
        return const IvTherapyPage();
      case ServiceType.labTests:
        return const LabTestsPage();
      case ServiceType.deepCleaning:
        return const DeepCleaningPage();
      case ServiceType.pestControl:
        return const PestControlPage();
      case ServiceType.packersMovers:
        return const PackersMoversPage();
      default:
        return const HomeCleaningPage();
    }
  }

  // Main navigation function with splash screen
  static void navigateToService(BuildContext context, ServiceModel service) {
    final targetPage = getTargetPage(service.serviceType);

    // Navigator.push se splash screen dikhao
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DynamicSplashScreen(
          service: service,
          targetPage: targetPage,
        ),
      ),
    );
  }
}