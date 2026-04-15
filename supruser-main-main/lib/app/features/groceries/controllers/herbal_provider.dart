import 'package:flutter/material.dart';
import 'package:suprapp/app/features/groceries/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductModleherbal? _selectedProduct;

  ProductModleherbal? get selectedProduct => _selectedProduct;

  void setSelectedProduct(ProductModleherbal product) {
    _selectedProduct = product;
    notifyListeners();
  }
}
