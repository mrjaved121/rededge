// ignore_for_file: public_member_api_docs, sort_constructors_first
// models/cart_item_model.dart

import 'dart:convert';

class ShopCartModel {
  final String id;
  final String name;
  final String imageUrl;

  final double price;
  final int count;
  final String foodItemId;
  ShopCartModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.count,
    required this.foodItemId,
  });

  ShopCartModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? price,
    int? count,
    String? foodItemId,
  }) {
    return ShopCartModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      count: count ?? this.count,
      foodItemId: foodItemId ?? this.foodItemId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'count': count,
      'foodItemId': foodItemId,
    };
  }

  factory ShopCartModel.fromMap(Map<String, dynamic> map) {
    return ShopCartModel(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      price: map['price'] as double,
      count: map['count'] as int,
      foodItemId: map['foodItemId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopCartModel.fromJson(String source) =>
      ShopCartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShopCartModel(id: $id, name: $name, imageUrl: $imageUrl, price: $price, count: $count, foodItemId: $foodItemId)';
  }

  @override
  bool operator ==(covariant ShopCartModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.price == price &&
        other.count == count &&
        other.foodItemId == foodItemId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        price.hashCode ^
        count.hashCode ^
        foodItemId.hashCode;
  }
}
