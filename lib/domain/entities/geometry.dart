

import 'package:wheelmap/domain/entities/coordinate.dart';
import 'package:wheelmap/domain/entities/enum_values.dart';

import '../../common/utils/log.dart';

/* This class represent the geographic features, including type of the feature,
geometry of the feature and its properties */

class Geometry {
  //String type;
  GeometryType type;
  // List<double> coordinates;
  Coordinate coordinate;

  Geometry({
    required this.type,
    required this.coordinate,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    try {
      return Geometry(
        //type: json["type"],
        type: geometryTypeValues.map[json["type"]]!,
        coordinate: Coordinate.fromJson(json),
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}

enum GeometryType { POINT }

final geometryTypeValues = EnumValues({
  "Point": GeometryType.POINT
});