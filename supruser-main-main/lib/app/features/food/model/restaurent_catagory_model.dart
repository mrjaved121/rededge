// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RestaurantCategoryModel {
  final String categoryId;
  final String categoryName;
  final String catagoryImage;
  RestaurantCategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.catagoryImage,
  });

  RestaurantCategoryModel copyWith({
    String? categoryId,
    String? categoryName,
    String? catagoryImage,
  }) {
    return RestaurantCategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      catagoryImage: catagoryImage ?? this.catagoryImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'categoryName': categoryName,
      'catagoryImage': catagoryImage,
    };
  }

  factory RestaurantCategoryModel.fromMap(Map<String, dynamic> map) {
    return RestaurantCategoryModel(
      categoryId: map['categoryId'] as String,
      categoryName: map['categoryName'] as String,
      catagoryImage: map['catagoryImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantCategoryModel.fromJson(String source) =>
      RestaurantCategoryModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RestaurantCategoryModel(categoryId: $categoryId, categoryName: $categoryName, catagoryImage: $catagoryImage)';

  @override
  bool operator ==(covariant RestaurantCategoryModel other) {
    if (identical(this, other)) return true;

    return other.categoryId == categoryId &&
        other.categoryName == categoryName &&
        other.catagoryImage == catagoryImage;
  }

  @override
  int get hashCode =>
      categoryId.hashCode ^ categoryName.hashCode ^ catagoryImage.hashCode;
}
