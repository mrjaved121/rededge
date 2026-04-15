// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ShopsCatagory {
  final String shopcatagoryImage;
  final String shopname;
  final String shopid;
  ShopsCatagory({
    required this.shopcatagoryImage,
    required this.shopname,
    required this.shopid,
  });

  ShopsCatagory copyWith({
    String? shopcatagoryImage,
    String? shopname,
    String? shopid,
  }) {
    return ShopsCatagory(
      shopcatagoryImage: shopcatagoryImage ?? this.shopcatagoryImage,
      shopname: shopname ?? this.shopname,
      shopid: shopid ?? this.shopid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shopcatagoryImage': shopcatagoryImage,
      'shopname': shopname,
      'shopid': shopid,
    };
  }

  factory ShopsCatagory.fromMap(Map<String, dynamic> map) {
    return ShopsCatagory(
      shopcatagoryImage: map['shopcatagoryImage'] as String,
      shopname: map['shopname'] as String,
      shopid: map['shopid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopsCatagory.fromJson(String source) =>
      ShopsCatagory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ShopsCatagory(shopcatagoryImage: $shopcatagoryImage, shopname: $shopname, shopid: $shopid)';

  @override
  bool operator ==(covariant ShopsCatagory other) {
    if (identical(this, other)) return true;

    return other.shopcatagoryImage == shopcatagoryImage &&
        other.shopname == shopname &&
        other.shopid == shopid;
  }

  @override
  int get hashCode =>
      shopcatagoryImage.hashCode ^ shopname.hashCode ^ shopid.hashCode;
}
