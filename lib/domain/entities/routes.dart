//Add the required fields to the Route class as defined in routes.json file :
import 'package:wheelmap/common/utils/log.dart';

class Route {
  final String name;
  final String description;
  final String imageURL;
  final String rating;
  List<Waypoint> waypoints;

  Route(
      {required this.name, required this.description, required this.imageURL, required this.rating, required this.waypoints});

  factory Route.fromJson(Map<String, dynamic> json) {
    try {
      List<Waypoint> waypoints = json['waypoints'].map<Waypoint>((wp) {
        return Waypoint(address: wp['address'],
            latitude: wp['latitude'],
            longitude: wp['longitude']);
      }).toList();
      return Route(
          name: json['name'],
          description: json['description'],
          imageURL: json['imageURL'],
          rating: json['rating'],
          waypoints: waypoints
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

}

class Waypoint {
  String address;
  double latitude;
  double longitude;

  Waypoint({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
    address: json["address"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
  };
}

