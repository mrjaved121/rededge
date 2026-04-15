import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suprapp/app/features/shops/models/all_shops_model.dart';
import 'package:suprapp/app/features/shops/models/shop_spec_model.dart';
import 'package:suprapp/app/features/shops/models/specific_shop_model.dart';

class ShopService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<AllShopsModel>> getAllShops() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('Shops').get();

      return snapshot.docs.map((doc) {
        return AllShopsModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error getting shops: $e');
      return [];
    }
  }

  Future<List<AllShopsModel>> getRecommendedShops() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Shops')
          .where('isRecommended', isEqualTo: true) // <-- filter here
          .get();

      return snapshot.docs.map((doc) {
        return AllShopsModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error getting recommended shops: $e');
      return [];
    }
  }

  Future<List<ShopWithSpecifics>> getShopsWithSpecifics() async {
    final shopsSnapshot = await _firestore.collection("Shops").get();
    List<ShopWithSpecifics> shopList = [];

    for (var doc in shopsSnapshot.docs) {
      final shopData = doc.data();
      final shopModel = AllShopsModel.fromMap(shopData);

      final specShopsSnapshot = await _firestore
          .collection("Shops")
          .doc(doc.id)
          .collection("Spec Shops")
          .get();

      final specificShops = specShopsSnapshot.docs
          .map((e) => SpecificShopModel.fromMap(e.data()))
          .toList();

      shopList.add(ShopWithSpecifics(
        shop: shopModel,
        specificShops: specificShops,
      ));
    }

    return shopList;
  }
}
