// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FoodItemModel {
  final String foodId;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final bool isVeg;
  final bool isAvailable;
  FoodItemModel({
    required this.foodId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.isVeg,
    required this.isAvailable,
  });

  FoodItemModel copyWith({
    String? foodId,
    String? name,
    String? description,
    String? imageUrl,
    double? price,
    bool? isVeg,
    bool? isAvailable,
  }) {
    return FoodItemModel(
      foodId: foodId ?? this.foodId,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      isVeg: isVeg ?? this.isVeg,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'foodId': foodId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'isVeg': isVeg,
      'isAvailable': isAvailable,
    };
  }

  factory FoodItemModel.fromMap(Map<String, dynamic> map) {
    return FoodItemModel(
      foodId: map['foodId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      price: map['price'] as double,
      isVeg: map['isVeg'] as bool,
      isAvailable: map['isAvailable'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodItemModel.fromJson(String source) =>
      FoodItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FoodItemModel(foodId: $foodId, name: $name, description: $description, imageUrl: $imageUrl, price: $price, isVeg: $isVeg, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(covariant FoodItemModel other) {
    if (identical(this, other)) return true;

    return other.foodId == foodId &&
        other.name == name &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.price == price &&
        other.isVeg == isVeg &&
        other.isAvailable == isAvailable;
  }

  @override
  int get hashCode {
    return foodId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        price.hashCode ^
        isVeg.hashCode ^
        isAvailable.hashCode;
  }
}
