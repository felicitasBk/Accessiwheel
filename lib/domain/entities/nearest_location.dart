import 'dart:math';

import 'package:wheelmap/domain/entities/feature.dart';
import 'package:wheelmap/domain/entities/geometry.dart';
import 'package:wheelmap/domain/entities/properties.dart';

class NearestLocation extends Feature {
  final double distance;

  NearestLocation({
    required this.distance,
    required FeatureType type,
    required Geometry geometry,
    required Properties properties,
  }) : super(
          type: type,
          geometry: geometry,
          properties: properties,
        );

  Future<List<NearestLocation>> findNearestLocations(
      List<Feature>? allLocations, Feature currentLocation, int count) async {
    final double currentLatitude = currentLocation.geometry.coordinate.latitude;
    final double currentLongitude =
        currentLocation.geometry.coordinate.longitude;

    final List<NearestLocation> locations = [];

    if (allLocations != null) {
      for (final Feature item in allLocations) {
        final double itemLatitude = item.geometry.coordinate.latitude;
        final double itemLongitude = item.geometry.coordinate.longitude;

        // Exclude the input location itself
        if (itemLatitude == currentLatitude &&
            itemLongitude == currentLongitude) {
          continue;
        }

        final String currentCategory = currentLocation.properties.category;
        final String itemCategory = item.properties.category;
        // Check if the category matches the input location's category
        if (itemCategory == currentCategory) {
          final double distance = calculateDistance(
              currentLatitude, currentLongitude, itemLatitude, itemLongitude);

          locations.add(NearestLocation(
            distance: distance,
            type: item.type,
            geometry: item.geometry,
            properties: item.properties,
          ));
        }
      }
      locations.sort((a, b) => a.distance.compareTo(b.distance));
    }

    return locations.sublist(0, min(count, locations.length));
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // in kilometers

    final double dLat = degreesToRadians(lat2 - lat1);
    final double dLon = degreesToRadians(lon2 - lon1);

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degreesToRadians(lat1)) *
            cos(degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final double distance = earthRadius * c;

    return double.parse(distance.toStringAsFixed(3));
  }

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  String getDistance() {
    if (distance < 1) {
      // Convert distance to meters
      final int distanceInMeters = (distance * 1000).toInt();
      return '$distanceInMeters m';
    } else {
      // Return distance in kilometers
      return '$distance km';
    }
  }
}
