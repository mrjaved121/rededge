// import 'package:flutter/material.dart';

// class QuantityProvider with ChangeNotifier {
//   final Map<String, int> _quantities = {};
//   final Map<String, double> _prices = {};

//   int _incrementCount = 0;

//   int getQuantity(String productId) => _quantities[productId] ?? 0;

//   double getTotalPrice(String productId) {
//     final quantity = getQuantity(productId);
//     final price = _prices[productId] ?? 0;
//     return quantity * price;
//   }

//   double get totalAmount {
//     double total = 0;
//     _quantities.forEach((productId, quantity) {
//       final price = _prices[productId] ?? 0;
//       total += price * quantity;
//     });
//     return total;
//   }

//   int get totalUniqueItems => _quantities.length;

//   int get totalIncrementCount => _incrementCount;

//   void increase(String productId, double price) {
//     _quantities[productId] = getQuantity(productId) + 1;
//     _prices[productId] = price;
//     _incrementCount++;
//     notifyListeners();
//   }

//   void decrease(String productId, double price) {
//     final current = getQuantity(productId);
//     if (current > 1) {
//       _quantities[productId] = current - 1;
//     } else {
//       _quantities.remove(productId);
//       _prices.remove(productId);
//     }
//     notifyListeners();
//   }

//   void remove(String productId) {
//     _quantities.remove(productId);
//     _prices.remove(productId);
//     notifyListeners();
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:suprapp/app/features/groceries/models/product_model.dart';

class QuantityProvider with ChangeNotifier {
  final Map<String, int> _quantities = {};
  final Map<String, double> _prices = {};

  int _incrementCount = 0;

  final List<ProductModleherbal> basketedList = [];

  int getQuantity(String productId) => _quantities[productId] ?? 0;
  void deleteBasket(int index) {
    basketedList.removeAt(index);
    notifyListeners();
  }

  double getTotalPrice(String productId) {
    final quantity = getQuantity(productId);
    final price = _prices[productId] ?? 0;
    return quantity * price;
  }

  double get totalAmount {
    double total = 0;
    _quantities.forEach((productId, quantity) {
      final price = _prices[productId] ?? 0;
      total += price * quantity;
    });
    return total;
  }

  int get totalUniqueItems => _quantities.length;

  int get totalIncrementCount => _incrementCount;

  void increase(String productId, double price, ProductModleherbal product) {
    _quantities[productId] = getQuantity(productId) + 1;
    _prices[productId] = price;
    _incrementCount++;

    final totalItem = _quantities[productId]!;
    final totalPrice = (price * totalItem).toInt();

    final existingIndex =
        basketedList.indexWhere((element) => element.id == productId);
    if (existingIndex != -1) {
      basketedList[existingIndex] = basketedList[existingIndex].copyWith(
        currentTotalItem: totalItem,
        currentTotalPrice: totalPrice,
      );
    } else {
      basketedList.add(
        product.copyWith(
          currentTotalItem: totalItem,
          currentTotalPrice: totalPrice,
        ),
      );
    }
    log('--------decrease basket------: ${basketedList.map((e) => '${e.title}: ${e.currentTotalItem} ---price---${e.currentTotalPrice}')}');

    notifyListeners();
  }

  void decrease(String productId, double price) {
    final current = getQuantity(productId);
    if (current > 1) {
      _quantities[productId] = current - 1;
      final totalItem = _quantities[productId]!;
      final totalPrice = (price * totalItem).toInt();

      final existingIndex =
          basketedList.indexWhere((element) => element.id == productId);
      if (existingIndex != -1) {
        basketedList[existingIndex] = basketedList[existingIndex].copyWith(
          currentTotalItem: totalItem,
          currentTotalPrice: totalPrice,
        );
      }
    } else {
      _quantities.remove(productId);
      _prices.remove(productId);
      basketedList.removeWhere((element) => element.id == productId);
    }
    log('--------decrease basket------: ${basketedList.map((e) => '${e.title}: ${e.currentTotalItem} ---price---${e.currentTotalPrice}')}');

    notifyListeners();
  }

  void remove(String productId) {
    _quantities.remove(productId);
    _prices.remove(productId);
    basketedList.removeWhere((element) => element.id == productId);
    notifyListeners();
  }
}
