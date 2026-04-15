import 'package:flutter/material.dart';
import 'package:suprapp/app/features/dine_out/model/dine_out_model.dart';

class DineOutProvider extends ChangeNotifier {
  final List<NestedItem> _items = mydinout; // using your predefined list

  List<NestedItem> get items => _items;

  NestedItem getItemByIndex(int index) => _items[index];

  AnotherDiscription getAnotherByIndex(int parentIndex, int childIndex) =>
      _items[parentIndex].anotherDiscription[childIndex];
}
