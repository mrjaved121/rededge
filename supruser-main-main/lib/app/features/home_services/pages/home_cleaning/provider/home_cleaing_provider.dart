import 'package:flutter/material.dart';

import '../../../Serviesdatamodel/servvices_datamodel.dart';
import '../../../dataofallservice/dataofsalon_spa.dart';

class BookingProvider extends ChangeNotifier {
  // ==================== EXISTING FIELDS ====================
  String _location = "My apartment";
  String _address = "shbs, vsusj, Al Rashidiya - Dubai, Dubai";

  bool _isHomeCleaningService = false;

  bool get isHomeCleaningService => _isHomeCleaningService;

  void setIsHomeCleaningService(bool value) {
    _isHomeCleaningService = value;
    if (!value) {
      _selectedHours = null;
      _selectedProfessionals = null;
      _subtotal = 0.0;
      _serviceFee = 0.0;
    }
    notifyListeners();
  }
  int? _selectedHours;
  int? _selectedProfessionals;
  bool _needMaterials = false;
  String _frequency = "One time";
  DateTime? _selectedDate;
  String? _selectedTime;
  String _paymentMethod = "Pay with Careem Pay";
  double _subtotal = 0.0;
  double _serviceFee = 0.0;
  String? _voucherCode;
  double _discountAmount = 0.0;
  List<AddOnService> _selectedAddOns = [];
  final Map<AddOnService, int> _addOnQuantities = {};

  // ==================== SERVICE FIELDS ====================
  ServiceCategory? _currentCategory;
  String? _selectedTab;
  final List<Service> _selectedServices = [];
  final Map<Service, int> _serviceQuantities = {};

  // ==================== GETTERS ====================
  String get location => _location;
  String get address => _address;
  int? get selectedHours => _selectedHours;
  int? get selectedProfessionals => _selectedProfessionals;
  int get hours => _selectedHours ?? 2;
  int get professionals => _selectedProfessionals ?? 1;
  bool get needMaterials => _needMaterials;
  String get frequency => _frequency;
  DateTime? get selectedDate => _selectedDate;
  String? get selectedTime => _selectedTime;
  String get paymentMethod => _paymentMethod;
  double get subtotal => _subtotal;
  double get serviceFee => _serviceFee;
  double get discountAmount => _discountAmount;
  String? get voucherCode => _voucherCode;
  List<AddOnService> get selectedAddOns => _selectedAddOns;

  ServiceCategory? get currentCategory => _currentCategory;
  String? get selectedTab => _selectedTab;
  List<Service> get selectedServices => _selectedServices;

  List<Service> get filteredServices {
    if (_currentCategory == null) return [];
    if (_selectedTab == null || _selectedTab!.isEmpty) {
      return _currentCategory!.services;
    }
    return _currentCategory!.services.where((service) {
      return service.tabCategory?.toLowerCase() == _selectedTab!.toLowerCase();
    }).toList();
  }

  bool get _hasServiceSelected => _selectedServices.isNotEmpty;


  double get addOnsTotal {
    double total = 0.0;
    for (var addOn in _selectedAddOns) {
      int quantity = _addOnQuantities[addOn] ?? 1;
      total += addOn.price * quantity;
    }
    return total;
  }

  double get servicesTotal {
    double total = 0.0;
    for (var service in _selectedServices) {
      int quantity = _serviceQuantities[service] ?? 1;
      total += service.price * quantity;
    }
    return total;
  }

  double get total {
    if (!_hasServiceSelected && _selectedHours == null && _selectedProfessionals == null) {
      return 0.0;
    }

    double bookingTotal = _subtotal + addOnsTotal - _discountAmount;


    if (_hasServiceSelected) {
      bookingTotal += servicesTotal;
    }

    if (bookingTotal > 0) {
      bookingTotal += _serviceFee;
    }

    return bookingTotal;
  }

  // ==================== SERVICE METHODS ====================

  void loadCategory(String categoryId) {
    _currentCategory = DummyServicesData.getCategory(categoryId);
    _selectedTab = null;
    setIsHomeCleaningService(false);
    notifyListeners();
  }

  void setCategory(ServiceCategory category) {
    _currentCategory = category;
    _selectedTab = null;
    setIsHomeCleaningService(false);
    notifyListeners();
  }

  void selectTab(String tab) {
    _selectedTab = tab;
    notifyListeners();
  }

  void addService(Service service) {
    if (!_selectedServices.contains(service)) {
      _selectedServices.add(service);
      _serviceQuantities[service] = 1;
      _calculatePrice();
      notifyListeners();
    }
  }

  void removeService(String serviceId) {
    _selectedServices.removeWhere((s) => s.id == serviceId);
    _serviceQuantities.removeWhere((s, _) => s.id == serviceId);
    _calculatePrice();
    notifyListeners();
  }

  void increaseServiceQuantity(Service service) {
    if (_selectedServices.contains(service)) {
      int currentQty = _serviceQuantities[service] ?? 1;
      int maxQty = service.maxQuantity ?? 99;

      if (currentQty < maxQty) {
        _serviceQuantities[service] = currentQty + 1;
        notifyListeners();
      }
    }
  }

  void decreaseServiceQuantity(Service service) {
    if (_selectedServices.contains(service)) {
      int currentQty = _serviceQuantities[service] ?? 1;
      if (currentQty > 1) {
        _serviceQuantities[service] = currentQty - 1;
      } else {
        removeService(service.id);
        return;
      }
      notifyListeners();
    }
  }

  int getServiceQuantity(Service service) {
    return _serviceQuantities[service] ?? 0;
  }

  bool isServiceSelected(Service service) {
    return _selectedServices.contains(service);
  }

  void clearServices() {
    _selectedServices.clear();
    _serviceQuantities.clear();
    _calculatePrice();
    notifyListeners();
  }

  // ==================== ADD-ON METHODS ====================

  AddOnService? _findAddOnByTitle(AddOnService addOn) {
    try {
      return _selectedAddOns.firstWhere((a) => a.title == addOn.title);
    } catch (e) {
      return null;
    }
  }

  int getAddOnQuantity(AddOnService addOn) {

    final existingAddOn = _findAddOnByTitle(addOn);
    if (existingAddOn != null) {
      return _addOnQuantities[existingAddOn] ?? 0;
    }
    return 0;
  }

  bool isAddOnSelected(AddOnService addOn) {

    return _findAddOnByTitle(addOn) != null;
  }

  void addAddOn(AddOnService addOn) {
    final existing = _findAddOnByTitle(addOn);
    if (existing == null) {
      _selectedAddOns.add(addOn);
      _addOnQuantities[addOn] = 1;
      print("✅ AddOn ADDED: ${addOn.title}, Total: ${_selectedAddOns.length}");
      notifyListeners();
    } else {
      print("⚠️ AddOn already exists: ${addOn.title}");
    }
  }

  void increaseAddOnQuantity(AddOnService addOn) {
    final existing = _findAddOnByTitle(addOn);
    if (existing != null) {
      _addOnQuantities[existing] = (_addOnQuantities[existing] ?? 1) + 1;
      print("➕ Increased: ${existing.title}, Qty: ${_addOnQuantities[existing]}");
      notifyListeners();
    }
  }

  void decreaseAddOnQuantity(AddOnService addOn) {
    final existing = _findAddOnByTitle(addOn);
    if (existing != null) {
      int currentQuantity = _addOnQuantities[existing] ?? 1;
      if (currentQuantity > 1) {
        _addOnQuantities[existing] = currentQuantity - 1;
        print("➖ Decreased: ${existing.title}, Qty: ${_addOnQuantities[existing]}");
      } else {
        _selectedAddOns.remove(existing);
        _addOnQuantities.remove(existing);
        print("🗑️ Removed: ${existing.title}");
      }
      notifyListeners();
    }
  }


  void resetServices() {
    _currentCategory = null;
    _selectedTab = null;
    _selectedServices.clear();
    _serviceQuantities.clear();
    _calculatePrice();
    notifyListeners();
  }

  void resetAddOns() {
    _selectedAddOns.clear();
    _addOnQuantities.clear();
    notifyListeners();
  }

  void resetBookingDetails() {
    _selectedHours = null;
    _selectedProfessionals = null;
    _needMaterials = false;
    _frequency = "One time";
    _calculatePrice();
    notifyListeners();
  }

  void resetDateTime() {
    _selectedDate = null;
    _selectedTime = null;
    notifyListeners();
  }

  void resetPayment() {
    _paymentMethod = "Pay with Careem Pay";
    _voucherCode = null;
    _discountAmount = 0.0;
    notifyListeners();
  }

  void resetAll() {
    resetServices();
    resetAddOns();
    resetBookingDetails();
    resetDateTime();
    resetPayment();
    notifyListeners();
  }

  void resetCurrentService() {
    resetServices();
    resetAddOns();
    resetBookingDetails();
    resetDateTime();
    resetPayment();
    notifyListeners();
  }

  // ==================== BOOKING METHODS ====================

  void setHours(int value) {
    if (_isHomeCleaningService) {
      _selectedHours = value;
      _calculatePrice();
      notifyListeners();
    }
  }
  void setProfessionals(int value) {
    if (_isHomeCleaningService) {
      _selectedProfessionals = value;
      _calculatePrice();
      notifyListeners();
    }
  }

  void setNeedMaterials(bool value) {
    _needMaterials = value;
    notifyListeners();
  }

  void setFrequency(String value) {
    _frequency = value;
    _calculatePrice();
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSelectedTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    _paymentMethod = method;
    notifyListeners();
  }

  void applyVoucher(String code) {
    _voucherCode = code;
    if (code == "50OFFER") {
      _discountAmount = 50.0;
    }
    notifyListeners();
  }

  void _calculatePrice() {
    if (!_isHomeCleaningService) {
      _subtotal = 0.0;
      _serviceFee = 0.0;
      return;
    }


    if (_selectedHours == null && _selectedProfessionals == null) {
      _subtotal = 0.0;
      _serviceFee = 0.0;
      return;
    }

    int hoursToUse = _selectedHours ?? 2;
    int professionalsToUse = _selectedProfessionals ?? 1;

    double basePrice = hoursToUse * 39.0 * professionalsToUse;

    if (_frequency == "Once a week") {
      basePrice *= 0.9;
    } else if (_frequency == "Every 2 weeks") {
      basePrice *= 0.95;
    } else if (_frequency == "Multiple times a week") {
      basePrice *= 0.75;
    }

    _subtotal = basePrice;
    _serviceFee = 9.0;
  }
}

class AddOnService {
  final String title;
  final String description;
  final double price;
  final double originalPrice;
  final String image;

  AddOnService({
    required this.title,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.image,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AddOnService &&
              runtimeType == other.runtimeType &&
              title == other.title;

  @override
  int get hashCode => title.hashCode;
}
