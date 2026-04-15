// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:suprapp/app/features/food/model/food_item_model.dart';

import 'package:suprapp/app/features/food/model/restaurent_catagory_model.dart';

class RestaurentModel {
  final String restaurentName;
  final String backgroundPhoto;
  final String coverPhoto;
  final String ratings;
  final String arriveTime;
  final String deliveryfee;
  final List<RestaurantCategoryModel> categories;
  final bool isGroupOrder;
  final bool freeDelivery;
  final bool offers;
  final String restaurentId;
  final List<FoodItemModel> foodItems;
  final String offersText;
  RestaurentModel({
    required this.restaurentName,
    required this.backgroundPhoto,
    required this.coverPhoto,
    required this.ratings,
    required this.arriveTime,
    required this.deliveryfee,
    required this.categories,
    required this.isGroupOrder,
    required this.freeDelivery,
    required this.offers,
    required this.restaurentId,
    required this.foodItems,
    required this.offersText,
  });

  RestaurentModel copyWith({
    String? restaurentName,
    String? backgroundPhoto,
    String? coverPhoto,
    String? ratings,
    String? arriveTime,
    String? deliveryfee,
    List<RestaurantCategoryModel>? categories,
    bool? isGroupOrder,
    bool? freeDelivery,
    bool? offers,
    String? restaurentId,
    List<FoodItemModel>? foodItems,
    String? offersText,
  }) {
    return RestaurentModel(
      restaurentName: restaurentName ?? this.restaurentName,
      backgroundPhoto: backgroundPhoto ?? this.backgroundPhoto,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      ratings: ratings ?? this.ratings,
      arriveTime: arriveTime ?? this.arriveTime,
      deliveryfee: deliveryfee ?? this.deliveryfee,
      categories: categories ?? this.categories,
      isGroupOrder: isGroupOrder ?? this.isGroupOrder,
      freeDelivery: freeDelivery ?? this.freeDelivery,
      offers: offers ?? this.offers,
      restaurentId: restaurentId ?? this.restaurentId,
      foodItems: foodItems ?? this.foodItems,
      offersText: offersText ?? this.offersText,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'restaurentName': restaurentName,
      'backgroundPhoto': backgroundPhoto,
      'coverPhoto': coverPhoto,
      'ratings': ratings,
      'arriveTime': arriveTime,
      'deliveryfee': deliveryfee,
      'categories': categories.map((x) => x.toMap()).toList(),
      'isGroupOrder': isGroupOrder,
      'freeDelivery': freeDelivery,
      'offers': offers,
      'restaurentId': restaurentId,
      'foodItems': foodItems.map((x) => x.toMap()).toList(),
      'offersText': offersText,
    };
  }

  factory RestaurentModel.fromMap(Map<String, dynamic> map) {
    return RestaurentModel(
      restaurentName: map['restaurentName'] as String,
      backgroundPhoto: map['backgroundPhoto'] as String,
      coverPhoto: map['coverPhoto'] as String,
      ratings: map['ratings'] as String,
      arriveTime: map['arriveTime'] as String,
      deliveryfee: map['deliveryfee'] as String,
      categories: List<RestaurantCategoryModel>.from(
        (map['categories'] as List<int>).map<RestaurantCategoryModel>(
          (x) => RestaurantCategoryModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      isGroupOrder: map['isGroupOrder'] as bool,
      freeDelivery: map['freeDelivery'] as bool,
      offers: map['offers'] as bool,
      restaurentId: map['restaurentId'] as String,
      foodItems: List<FoodItemModel>.from(
        (map['foodItems'] as List<int>).map<FoodItemModel>(
          (x) => FoodItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      offersText: map['offersText'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurentModel.fromJson(String source) =>
      RestaurentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RestaurentModel(restaurentName: $restaurentName, backgroundPhoto: $backgroundPhoto, coverPhoto: $coverPhoto, ratings: $ratings, arriveTime: $arriveTime, deliveryfee: $deliveryfee, categories: $categories, isGroupOrder: $isGroupOrder, freeDelivery: $freeDelivery, offers: $offers, restaurentId: $restaurentId, foodItems: $foodItems, offersText: $offersText)';
  }

  @override
  bool operator ==(covariant RestaurentModel other) {
    if (identical(this, other)) return true;

    return other.restaurentName == restaurentName &&
        other.backgroundPhoto == backgroundPhoto &&
        other.coverPhoto == coverPhoto &&
        other.ratings == ratings &&
        other.arriveTime == arriveTime &&
        other.deliveryfee == deliveryfee &&
        listEquals(other.categories, categories) &&
        other.isGroupOrder == isGroupOrder &&
        other.freeDelivery == freeDelivery &&
        other.offers == offers &&
        other.restaurentId == restaurentId &&
        listEquals(other.foodItems, foodItems) &&
        other.offersText == offersText;
  }

  @override
  int get hashCode {
    return restaurentName.hashCode ^
        backgroundPhoto.hashCode ^
        coverPhoto.hashCode ^
        ratings.hashCode ^
        arriveTime.hashCode ^
        deliveryfee.hashCode ^
        categories.hashCode ^
        isGroupOrder.hashCode ^
        freeDelivery.hashCode ^
        offers.hashCode ^
        restaurentId.hashCode ^
        foodItems.hashCode ^
        offersText.hashCode;
  }
}
