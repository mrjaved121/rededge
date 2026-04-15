// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ShopProductsModel {
  final String productName;
  final String productImage;
  final int price;
  final String productId;
  final String shopspecificId;
  final String productDescription;
  final String amount;
  final String size;
  ShopProductsModel({
    required this.productName,
    required this.productImage,
    required this.price,
    required this.productId,
    required this.shopspecificId,
    required this.productDescription,
    required this.amount,
    required this.size,
  });

  ShopProductsModel copyWith({
    String? productName,
    String? productImage,
    int? price,
    String? productId,
    String? shopspecificId,
    String? productDescription,
    String? amount,
    String? size,
  }) {
    return ShopProductsModel(
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
      productId: productId ?? this.productId,
      shopspecificId: shopspecificId ?? this.shopspecificId,
      productDescription: productDescription ?? this.productDescription,
      amount: amount ?? this.amount,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'productId': productId,
      'shopspecificId': shopspecificId,
      'productDescription': productDescription,
      'amount': amount,
      'size': size,
    };
  }

  factory ShopProductsModel.fromMap(Map<String, dynamic> map) {
    return ShopProductsModel(
      productName: map['productName'] as String,
      productImage: map['productImage'] as String,
      price: map['price'] as int,
      productId: map['productId'] as String,
      shopspecificId: map['shopspecificId'] as String,
      productDescription: map['productDescription'] as String,
      amount: map['amount'] as String,
      size: map['size'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopProductsModel.fromJson(String source) =>
      ShopProductsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShopProductsModel(productName: $productName, productImage: $productImage, price: $price, productId: $productId, shopspecificId: $shopspecificId, productDescription: $productDescription, amount: $amount, size: $size)';
  }

  @override
  bool operator ==(covariant ShopProductsModel other) {
    if (identical(this, other)) return true;

    return other.productName == productName &&
        other.productImage == productImage &&
        other.price == price &&
        other.productId == productId &&
        other.shopspecificId == shopspecificId &&
        other.productDescription == productDescription &&
        other.amount == amount &&
        other.size == size;
  }

  @override
  int get hashCode {
    return productName.hashCode ^
        productImage.hashCode ^
        price.hashCode ^
        productId.hashCode ^
        shopspecificId.hashCode ^
        productDescription.hashCode ^
        amount.hashCode ^
        size.hashCode;
  }
}
