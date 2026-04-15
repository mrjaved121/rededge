// ==================== ORDER DATA MODEL ====================
// Create this file: lib/app/features/home_services/models/laundry_order_model.dart

class LaundryOrderData {
  final String serviceType;
  final Map<String, ItemDetail> individualItems;
  final int bedBathQty;
  final int washFoldQty;
  final Map<String, ItemDetail> shoeItems;
  final Map<String, ItemDetail> bagItems;
  final String? selectedCareType;

  LaundryOrderData({
    required this.serviceType,
    this.individualItems = const {},
    this.bedBathQty = 0,
    this.washFoldQty = 0,
    this.shoeItems = const {},
    this.bagItems = const {},
    this.selectedCareType,
  });

  // Convert to Map for navigation
  Map<String, dynamic> toMap() {
    return {
      'serviceType': serviceType,
      'individualItems': individualItems.map((key, value) => MapEntry(key, value.toMap())),
      'bedBathQty': bedBathQty,
      'washFoldQty': washFoldQty,
      'shoeItems': shoeItems.map((key, value) => MapEntry(key, value.toMap())),
      'bagItems': bagItems.map((key, value) => MapEntry(key, value.toMap())),
      'selectedCareType': selectedCareType,
    };
  }

  // Create from Map
  factory LaundryOrderData.fromMap(Map<String, dynamic> map) {
    return LaundryOrderData(
      serviceType: map['serviceType'] as String? ?? '',
      individualItems: _parseItems(map['individualItems']),
      bedBathQty: map['bedBathQty'] as int? ?? 0,
      washFoldQty: map['washFoldQty'] as int? ?? 0,
      shoeItems: _parseItems(map['shoeItems']),
      bagItems: _parseItems(map['bagItems']),
      selectedCareType: map['selectedCareType'] as String?,
    );
  }

  static Map<String, ItemDetail> _parseItems(dynamic items) {
    if (items == null) return {};
    if (items is Map<String, dynamic>) {
      return items.map((key, value) {
        if (value is Map<String, dynamic>) {
          return MapEntry(key, ItemDetail.fromMap(value));
        }
        // Handle legacy format where value is just quantity
        return MapEntry(key, ItemDetail(
          name: key,
          quantity: value is int ? value : 1,
          price: 0,
        ));
      });
    }
    return {};
  }

  // Calculate total items count
  int getTotalItemsCount() {
    int total = 0;
    total += individualItems.values.fold(0, (sum, item) => sum + item.quantity);
    total += bedBathQty;
    total += washFoldQty;
    total += shoeItems.values.fold(0, (sum, item) => sum + item.quantity);
    total += bagItems.values.fold(0, (sum, item) => sum + item.quantity);
    return total;
  }

  // Get all items as list for display
  List<OrderItemDisplay> getAllItemsForDisplay() {
    List<OrderItemDisplay> displayItems = [];

    // Individual items
    individualItems.forEach((key, detail) {
      displayItems.add(OrderItemDisplay(
        name: detail.name,
        quantity: detail.quantity,
        price: detail.price,
        category: 'Laundry',
      ));
    });

    // Bed & Bath
    if (bedBathQty > 0) {
      displayItems.add(OrderItemDisplay(
        name: 'Bed & Bath Package',
        quantity: bedBathQty,
        price: 66.0,
        category: 'Package',
      ));
    }

    // Wash & Fold
    if (washFoldQty > 0) {
      displayItems.add(OrderItemDisplay(
        name: 'Wash & Fold Package',
        quantity: washFoldQty,
        price: 55.0,
        category: 'Package',
      ));
    }

    // Shoe items
    shoeItems.forEach((key, detail) {
      displayItems.add(OrderItemDisplay(
        name: detail.name,
        quantity: detail.quantity,
        price: detail.price,
        category: 'Shoe Care',
      ));
    });

    // Bag items
    bagItems.forEach((key, detail) {
      displayItems.add(OrderItemDisplay(
        name: detail.name,
        quantity: detail.quantity,
        price: detail.price,
        category: 'Bag Care',
      ));
    });

    return displayItems;
  }
}

class ItemDetail {
  final String name;
  final int quantity;
  final double price;

  ItemDetail({
    required this.name,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  factory ItemDetail.fromMap(Map<String, dynamic> map) {
    return ItemDetail(
      name: map['name'] as String? ?? '',
      quantity: map['quantity'] as int? ?? 0,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class OrderItemDisplay {
  final String name;
  final int quantity;
  final double price;
  final String category;

  OrderItemDisplay({
    required this.name,
    required this.quantity,
    required this.price,
    required this.category,
  });

  double get total => price * quantity;
}

// ==================== PRICE CALCULATOR ====================
class LaundryPriceCalculator {
  // Item prices map
  static const Map<String, double> itemPrices = {
    'shirt': 13.0,
    't_shirt': 18.0,
    'blouse': 18.0,
    'shorts': 18.0,
    'pants': 23.0,
    'skirt': 23.0,
    'jeans': 23.0,
    'bra': 6.0,
    'underwear': 3.0,
    'bedsheet': 29.0,
    'floormat': 17.0,
    'handkerchief': 6.0,
    'evening_dress': 75.0,
    'complex_dress': 95.0,
    'basic_dress': 45.0,
    'veil': 15.0,
    'coat': 66.0,
    'kandura': 15.0,
    'jacket': 74.0,
    'abaya': 18.0,
    'gathra': 10.0,
    'thick_sweater': 48.0,
    'sweater': 38.0,
    'sports_sweater': 28.0,
    'pyjama_pants': 18.0,
    'pyjama_full': 15.0,
    'cap': 16.0,
    'jumpsuit': 36.0,
    'sirwal': 12.0,
    'kurta_mens': 15.0,
    'kurta_womens': 31.0,
    'carpet_regular': 35.0,
  };

  // Shoe prices map
  static const Map<String, double> shoePrices = {
    'Formal Shoe Polishing': 75.0,
    'Sports Sneakers': 95.0,
    'Designer Sneakers': 145.0,
    'Formal Shoes': 110.0,
    'Designer Formal': 145.0,
    'Sandals': 85.0,
    'Designer Sandals': 140.0,
    'Espadrilles': 90.0,
    'Designer Espadrilles': 140.0,
    'Kids Shoes': 65.0,
    'Boots': 170.0,
  };

  // Bag prices map
  static const Map<String, double> bagPrices = {
    'Extra Small': 150.0,
    'Small': 250.0,
    'Medium': 350.0,
    'Large': 450.0,
    'Extra Small_repair': 300.0,
    'Small_repair': 450.0,
    'Medium_repair': 650.0,
    'Large_repair': 1150.0,
  };

  static double getPriceForItem(String itemKey, String serviceType) {
    // Extract item ID from key (format: "itemId_serviceType")
    final parts = itemKey.split('_');
    final itemId = parts.isNotEmpty ? parts[0] : itemKey;

    double basePrice = itemPrices[itemId] ?? 0.0;

    // Adjust for iron service (30% discount)
    if (serviceType == 'iron') {
      return (basePrice * 0.7).roundToDouble();
    }

    return basePrice;
  }

  static double getPriceForShoe(String shoeName) {
    return shoePrices[shoeName] ?? 0.0;
  }

  static double getPriceForBag(String bagName, bool isRepair) {
    final key = isRepair ? '${bagName}_repair' : bagName;
    return bagPrices[key] ?? 0.0;
  }

  static double calculateTotal(LaundryOrderData orderData) {
    double total = 0.0;

    // Individual items
    orderData.individualItems.forEach((key, detail) {
      total += detail.price * detail.quantity;
    });

    // Packages
    total += orderData.bedBathQty * 66.0;
    total += orderData.washFoldQty * 55.0;

    // Shoe items
    orderData.shoeItems.forEach((key, detail) {
      total += detail.price * detail.quantity;
    });

    // Bag items
    orderData.bagItems.forEach((key, detail) {
      total += detail.price * detail.quantity;
    });

    return total;
  }
}