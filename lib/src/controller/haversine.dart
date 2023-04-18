import 'dart:math';
import 'package:location/location.dart';

class Haversine {
  static final R = 6372.8; // In kilometers

  static double haversine(double lat1, lon1, lat2, lon2) {
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    lat1 = _toRadians(lat1);
    lat2 = _toRadians(lat2);
    double a =
        pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);
    double c = 2 * asin(sqrt(a));
    return (R * c) * 1000;
  }

  static Future<double> getHaversine(double lat, long) async {
    var location = Location();
    final loc = await location.getLocation();

    return haversine(lat, long, loc.latitude, loc.longitude);
  }

  static double _toRadians(double degree) {
    return degree * pi / 180;
  }
}

class EditScreenArguments {
  final String customerId;
  final bool hasHistory;
  final bool isInAllowedDistance;
  final double currentLat;
  final double currentLong;
  final String previousLocation;

  EditScreenArguments(
    this.customerId,
    this.hasHistory,
    this.isInAllowedDistance,
    this.currentLat,
    this.currentLong,
    this.previousLocation,
  );
}
