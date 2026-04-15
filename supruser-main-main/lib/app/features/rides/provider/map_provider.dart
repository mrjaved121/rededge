import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:suprapp/app/config/maps_config.dart';

class MapProvider with ChangeNotifier {
  LatLng? _currentPosition;
  GoogleMapController? _mapController;
  List<Map<String, dynamic>> _placeSuggestions = [];
  Set<Polyline> _polylines = {};
  final String _apiKey = GOOGLE_MAPS_API_KEY;

  LatLng? get currentPosition => _currentPosition;
  List<Map<String, dynamic>> get placeSuggestions => _placeSuggestions;
  Set<Polyline> get polylines => _polylines;

  MapProvider() {
    _initLocation();
  }

  // Initialize live location
  Future<void> _initLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    LocationData locationData = await location.getLocation();
    _currentPosition = LatLng(locationData.latitude!, locationData.longitude!);
    notifyListeners();
  }

  // Handle map creation
  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_currentPosition != null) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition!, 14),
      );
    }
  }

  // Search for places using Google Places API
  Future<void> searchPlaces(String query) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          _placeSuggestions = List<Map<String, dynamic>>.from(data['results']);
        } else {
          _placeSuggestions = [];
          debugPrint('Google Places Error: ${data['status']}');
        }
      } else {
        _placeSuggestions = [];
        debugPrint('Failed to fetch places');
      }
    } catch (e) {
      _placeSuggestions = [];
      debugPrint('Error during place search: $e');
    }

    notifyListeners();
  }

  Future<void> drawPolyline(Map<String, dynamic> place) async {
    final location = place['geometry']['location'];
    if (_currentPosition == null || location == null) return;

    final LatLng destination = LatLng(location['lat'], location['lng']);

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition!.latitude},${_currentPosition!.longitude}&destination=${destination.latitude},${destination.longitude}&key=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          final route = data['routes'][0]['overview_polyline']['points'];
          final points = _decodePolyline(route);
          _polylines = {
            Polyline(
              polylineId: const PolylineId("route"),
              color: Colors.blue,
              width: 5,
              points: points,
            ),
          };

          _mapController?.animateCamera(
            CameraUpdate.newLatLngBounds(_boundsFromLatLngList(points), 50),
          );
        }
      }
    } catch (e) {
      debugPrint('Error drawing polyline: $e');
    }

    notifyListeners();
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double x0 = list.first.latitude, x1 = list.first.latitude;
    double y0 = list.first.longitude, y1 = list.first.longitude;
    for (LatLng latLng in list) {
      if (latLng.latitude > x1) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1) y1 = latLng.longitude;
      if (latLng.longitude < y0) y0 = latLng.longitude;
    }
    return LatLngBounds(
      southwest: LatLng(x0, y0),
      northeast: LatLng(x1, y1),
    );
  }

  void clear() {
    _placeSuggestions = [];
    _polylines.clear();
    notifyListeners();
  }
}