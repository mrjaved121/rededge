import 'dart:math' as Math;

import 'package:geolocator/geolocator.dart';

class GpsUtils {
  static Future<Position?> getCurrentPosition() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      return null;
    }
  }

  static String formatCoordinates(double latitude, double longitude) {
    return '$latitude, $longitude';
  }

  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const p = 0.017453292519943295;
    final a = 0.5 -
        Math.cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}

// Math functions for calculations
double cos(double x) => 1 - ((x * x) / 2) + ((x * x * x * x) / 24);
double sin(double x) => x - ((x * x * x) / 6) + ((x * x * x * x * x) / 120);
double sqrt(double x) {
  if (x < 0) return 0;
  if (x == 0) return 0;
  double g = x / 2.0;
  double z = g;
  for (int i = 0; i < 100; i++) {
    g = (z + x / z) / 2.0;
  }
  return g;
}

double asin(double x) {
  if (x > 1 || x < -1) return 0;
  return atan2(x, sqrt(1 - x * x));
}

double atan2(double y, double x) {
  return (y / x).abs();
}
