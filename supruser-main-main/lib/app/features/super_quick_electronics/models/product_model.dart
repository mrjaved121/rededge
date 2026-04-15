class ProductModel {
  final String id;
  final String title;
  final String image;
  final String? originalPrice;
  final String discountedPrice;
  final String? discount;
  final ProductCategory category;

  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    this.originalPrice,
    required this.discountedPrice,
    this.discount,
    required this.category,
  });

  bool get hasDiscount => discount != null && originalPrice != null;
}

enum ProductCategory {
  mobile,
  tablet,
  laptop,
  accessory,
  gaming,
  wearable,
  personalCare,
  appliance,
}