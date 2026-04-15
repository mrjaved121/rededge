import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Helper methods for MapProvider
class MapProviderHelpers {
  // Calculate distance between two points using Haversine formula
  static double calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371; // Earth's radius in kilometers
    final double lat1 = point1.latitude * (pi / 180);
    final double lat2 = point2.latitude * (pi / 180);
    final double lon1 = point1.longitude * (pi / 180);
    final double lon2 = point2.longitude * (pi / 180);

    final double dLat = lat2 - lat1;
    final double dLon = lon2 - lon1;

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  // Generate intermediate points for smooth curves
  static List<LatLng> generateIntermediatePoints(LatLng start, LatLng end) {
    const int numberOfPoints = 100;
    final List<LatLng> points = [];
    
    for (int i = 0; i <= numberOfPoints; i++) {
      final double fraction = i / numberOfPoints;
      
      // Use great circle path calculation for more accurate long-distance routes
      final double lat1 = start.latitude * pi / 180;
      final double lon1 = start.longitude * pi / 180;
      final double lat2 = end.latitude * pi / 180;
      final double lon2 = end.longitude * pi / 180;

      final double d = 2 * asin(sqrt(pow(sin((lat2 - lat1) / 2), 2) +
          cos(lat1) * cos(lat2) * pow(sin((lon2 - lon1) / 2), 2)));

      if (d == 0) {
        points.add(start);
        continue;
      }

      final double A = sin((1 - fraction) * d) / sin(d);
      final double B = sin(fraction * d) / sin(d);

      final double x = A * cos(lat1) * cos(lon1) + B * cos(lat2) * cos(lon2);
      final double y = A * cos(lat1) * sin(lon1) + B * cos(lat2) * sin(lon2);
      final double z = A * sin(lat1) + B * sin(lat2);

      final double lat = atan2(z, sqrt(x * x + y * y));
      final double lon = atan2(y, x);

      points.add(LatLng(lat * 180 / pi, lon * 180 / pi));
    }
    
    return points;
  }

  // Get bounds from list of points
  static LatLngBounds boundsFromLatLngList(List<LatLng> points) {
    if (points.isEmpty) {
      throw Exception('Points list cannot be empty');
    }
    
    double minLat = points[0].latitude;
    double maxLat = points[0].latitude;
    double minLng = points[0].longitude;
    double maxLng = points[0].longitude;
    
    for (final point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }
    
    return LatLngBounds(
      northeast: LatLng(maxLat, maxLng),
      southwest: LatLng(minLat, minLng),
    );
  }
}