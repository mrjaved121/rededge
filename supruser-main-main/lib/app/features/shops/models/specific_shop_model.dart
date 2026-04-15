// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SpecificShopModel {
  final String shopName;
  final String shopImage;
  final String shopId;
  final String rating;
  final String arriveTime;
  final String idSpecificShop;
  SpecificShopModel({
    required this.shopName,
    required this.shopImage,
    required this.shopId,
    required this.rating,
    required this.arriveTime,
    required this.idSpecificShop,
  });

  SpecificShopModel copyWith({
    String? shopName,
    String? shopImage,
    String? shopId,
    String? rating,
    String? arriveTime,
    String? idSpecificShop,
  }) {
    return SpecificShopModel(
      shopName: shopName ?? this.shopName,
      shopImage: shopImage ?? this.shopImage,
      shopId: shopId ?? this.shopId,
      rating: rating ?? this.rating,
      arriveTime: arriveTime ?? this.arriveTime,
      idSpecificShop: idSpecificShop ?? this.idSpecificShop,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shopName': shopName,
      'shopImage': shopImage,
      'shopId': shopId,
      'rating': rating,
      'arriveTime': arriveTime,
      'idSpecificShop': idSpecificShop,
    };
  }

  factory SpecificShopModel.fromMap(Map<String, dynamic> map) {
    return SpecificShopModel(
      shopName: map['shopName'] as String,
      shopImage: map['shopImage'] as String,
      shopId: map['shopId'] as String,
      rating: map['rating'] as String,
      arriveTime: map['arriveTime'] as String,
      idSpecificShop: map['idSpecificShop'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecificShopModel.fromJson(String source) =>
      SpecificShopModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SpecificShopModel(shopName: $shopName, shopImage: $shopImage, shopId: $shopId, rating: $rating, arriveTime: $arriveTime, idSpecificShop: $idSpecificShop)';
  }

  @override
  bool operator ==(covariant SpecificShopModel other) {
    if (identical(this, other)) return true;

    return other.shopName == shopName &&
        other.shopImage == shopImage &&
        other.shopId == shopId &&
        other.rating == rating &&
        other.arriveTime == arriveTime &&
        other.idSpecificShop == idSpecificShop;
  }

  @override
  int get hashCode {
    return shopName.hashCode ^
        shopImage.hashCode ^
        shopId.hashCode ^
        rating.hashCode ^
        arriveTime.hashCode ^
        idSpecificShop.hashCode;
  }
}
