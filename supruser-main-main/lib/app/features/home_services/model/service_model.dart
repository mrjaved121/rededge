class ServiceModel {
  final String id;
  final String title;
  final String? subtitle;
  final String imagePath;
  final bool hasOffer;
  final String? offerText;
  final String? offerCode;
  final double? originalPrice;
  final double? discountedPrice;
  final String? description;
  final List<String>? features;
  final ServiceType serviceType;

  ServiceModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.imagePath,
    this.hasOffer = false,
    this.offerText,
    this.offerCode,
    this.originalPrice,
    this.discountedPrice,
    this.description,
    this.features,
    required this.serviceType,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      imagePath: json['imagePath'],
      hasOffer: json['hasOffer'] ?? false,
      offerText: json['offerText'],
      offerCode: json['offerCode'],
      originalPrice: json['originalPrice']?.toDouble(),
      discountedPrice: json['discountedPrice']?.toDouble(),
      description: json['description'],
      features: json['features'] != null ? List<String>.from(json['features']) : null,
      serviceType: ServiceType.values.firstWhere(
            (e) => e.toString() == 'ServiceType.${json['serviceType']}',
        orElse: () => ServiceType.other,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'imagePath': imagePath,
      'hasOffer': hasOffer,
      'offerText': offerText,
      'offerCode': offerCode,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'description': description,
      'features': features,
      'serviceType': serviceType.toString().split('.').last,
    };
  }
}

enum ServiceType {
  homeCleaning,
  laundry,
  salonSpa,
  furnitureCleaning,
  acCleaning,
  ivTherapy,
  labTests,
  deepCleaning,
  pestControl,
  packersMovers,
  other
}