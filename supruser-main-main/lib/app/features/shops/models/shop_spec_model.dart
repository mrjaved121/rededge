import 'package:suprapp/app/features/shops/models/all_shops_model.dart';
import 'package:suprapp/app/features/shops/models/specific_shop_model.dart';

class ShopWithSpecifics {
  final AllShopsModel shop;
  final List<SpecificShopModel> specificShops;

  ShopWithSpecifics({
    required this.shop,
    required this.specificShops,
  });
}
