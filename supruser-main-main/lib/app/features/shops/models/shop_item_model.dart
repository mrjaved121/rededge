// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ShopItemModel {
  final String shopItemImage;
  final String shopItemName;
  final String shopItemId;
  final int price;
  final String quantity;
  final String shopItemDescription;
  final String size;
  final String washingTime;
  final bool mostPurchasedItem;
  final bool fresh;
  final bool sale;
  final bool exotic;
  final String shopid;
  ShopItemModel({
    required this.shopItemImage,
    required this.shopItemName,
    required this.shopItemId,
    required this.price,
    required this.quantity,
    required this.shopItemDescription,
    required this.size,
    required this.washingTime,
    required this.mostPurchasedItem,
    required this.fresh,
    required this.sale,
    required this.exotic,
    required this.shopid,
  });

  ShopItemModel copyWith({
    String? shopItemImage,
    String? shopItemName,
    String? shopItemId,
    int? price,
    String? quantity,
    String? shopItemDescription,
    String? size,
    String? washingTime,
    bool? mostPurchasedItem,
    bool? fresh,
    bool? sale,
    bool? exotic,
    String? shopid,
  }) {
    return ShopItemModel(
      shopItemImage: shopItemImage ?? this.shopItemImage,
      shopItemName: shopItemName ?? this.shopItemName,
      shopItemId: shopItemId ?? this.shopItemId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      shopItemDescription: shopItemDescription ?? this.shopItemDescription,
      size: size ?? this.size,
      washingTime: washingTime ?? this.washingTime,
      mostPurchasedItem: mostPurchasedItem ?? this.mostPurchasedItem,
      fresh: fresh ?? this.fresh,
      sale: sale ?? this.sale,
      exotic: exotic ?? this.exotic,
      shopid: shopid ?? this.shopid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shopItemImage': shopItemImage,
      'shopItemName': shopItemName,
      'shopItemId': shopItemId,
      'price': price,
      'quantity': quantity,
      'shopItemDescription': shopItemDescription,
      'size': size,
      'washingTime': washingTime,
      'mostPurchasedItem': mostPurchasedItem,
      'fresh': fresh,
      'sale': sale,
      'exotic': exotic,
      'shopid': shopid,
    };
  }

  factory ShopItemModel.fromMap(Map<String, dynamic> map) {
    return ShopItemModel(
      shopItemImage: map['shopItemImage'] as String,
      shopItemName: map['shopItemName'] as String,
      shopItemId: map['shopItemId'] as String,
      price: map['price'] as int,
      quantity: map['quantity'] as String,
      shopItemDescription: map['shopItemDescription'] as String,
      size: map['size'] as String,
      washingTime: map['washingTime'] as String,
      mostPurchasedItem: map['mostPurchasedItem'] as bool,
      fresh: map['fresh'] as bool,
      sale: map['sale'] as bool,
      exotic: map['exotic'] as bool,
      shopid: map['shopid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopItemModel.fromJson(String source) =>
      ShopItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShopItemModel(shopItemImage: $shopItemImage, shopItemName: $shopItemName, shopItemId: $shopItemId, price: $price, quantity: $quantity, shopItemDescription: $shopItemDescription, size: $size, washingTime: $washingTime, mostPurchasedItem: $mostPurchasedItem, fresh: $fresh, sale: $sale, exotic: $exotic, shopid: $shopid)';
  }

  @override
  bool operator ==(covariant ShopItemModel other) {
    if (identical(this, other)) return true;

    return other.shopItemImage == shopItemImage &&
        other.shopItemName == shopItemName &&
        other.shopItemId == shopItemId &&
        other.price == price &&
        other.quantity == quantity &&
        other.shopItemDescription == shopItemDescription &&
        other.size == size &&
        other.washingTime == washingTime &&
        other.mostPurchasedItem == mostPurchasedItem &&
        other.fresh == fresh &&
        other.sale == sale &&
        other.exotic == exotic &&
        other.shopid == shopid;
  }

  @override
  int get hashCode {
    return shopItemImage.hashCode ^
        shopItemName.hashCode ^
        shopItemId.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        shopItemDescription.hashCode ^
        size.hashCode ^
        washingTime.hashCode ^
        mostPurchasedItem.hashCode ^
        fresh.hashCode ^
        sale.hashCode ^
        exotic.hashCode ^
        shopid.hashCode;
  }
}
