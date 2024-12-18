// The class Coordinate represents a geographic coordinate, consisting of latitude and longitude values.
import '../../common/utils/log.dart';

class Coordinate {
  double latitude;
  double longitude;
  Coordinate({required this.latitude, required this.longitude});

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    try {
      var coordinatesList = json['coordinates'] as List<dynamic>;
      return Coordinate(
          latitude: coordinatesList.last! as double,
          longitude: coordinatesList.first! as double);
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}
