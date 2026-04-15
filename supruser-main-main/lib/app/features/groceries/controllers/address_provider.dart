import 'package:flutter/material.dart';
import 'package:suprapp/app/features/groceries/models/recent_places_model.dart';

class AddressProvider extends ChangeNotifier {
  final List<RecentPlace> _recentPlaces = [
    RecentPlace(title: 'Office', address: '2972 Westheimer Rd, Santa Ana, Illinois 85486', distance: 2.7),
    RecentPlace(title: 'Coffee shop', address: '1901 Thornridge Cir. Shiloh, Hawaii 81063', distance: 1.1),
    RecentPlace(title: 'Shopping center', address: '4140 Parker Rd. Allentown, New Mexico 31134', distance: 4.9),
    RecentPlace(title: 'Shopping mall', address: '4140 Parker Rd. Allentown, New Mexico 31134', distance: 4.0),
  ];

  List<RecentPlace> get recentPlaces => _recentPlaces;
}