// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AllShopsModel {
  final String shopImage;
  final String shopname;
  final String shopId;
  final bool isRecommended;
  AllShopsModel({
    required this.shopImage,
    required this.shopname,
    required this.shopId,
    required this.isRecommended,
  });

  AllShopsModel copyWith({
    String? shopImage,
    String? shopname,
    String? shopId,
    bool? isRecommended,
  }) {
    return AllShopsModel(
      shopImage: shopImage ?? this.shopImage,
      shopname: shopname ?? this.shopname,
      shopId: shopId ?? this.shopId,
      isRecommended: isRecommended ?? this.isRecommended,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shopImage': shopImage,
      'shopname': shopname,
      'shopId': shopId,
      'isRecommended': isRecommended,
    };
  }

  factory AllShopsModel.fromMap(Map<String, dynamic> map) {
    return AllShopsModel(
      shopImage: map['shopImage'] as String,
      shopname: map['shopname'] as String,
      shopId: map['shopId'] as String,
      isRecommended: map['isRecommended'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllShopsModel.fromJson(String source) =>
      AllShopsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AllShopsModel(shopImage: $shopImage, shopname: $shopname, shopId: $shopId, isRecommended: $isRecommended)';
  }

  @override
  bool operator ==(covariant AllShopsModel other) {
    if (identical(this, other)) return true;

    return other.shopImage == shopImage &&
        other.shopname == shopname &&
        other.shopId == shopId &&
        other.isRecommended == isRecommended;
  }

  @override
  int get hashCode {
    return shopImage.hashCode ^
        shopname.hashCode ^
        shopId.hashCode ^
        isRecommended.hashCode;
  }
}
