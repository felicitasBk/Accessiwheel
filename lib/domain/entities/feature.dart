import 'package:wheelmap/common/utils/log.dart';
import 'package:wheelmap/domain/entities/enum_values.dart';
import 'package:wheelmap/domain/entities/geometry.dart';
import 'package:wheelmap/domain/entities/properties.dart';

/*The purpose of this class is to represent a feature with its type, geometry, and properties,
 and provide a mechanism to create a Feature object from a JSON representation. */

class Feature {
  FeatureType type;
  Geometry geometry;
  Properties properties;

  Feature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    try {
      return Feature(
        type: featureTypeValues.map[json["type"]]!,
        geometry: Geometry.fromJson(json["geometry"]),
        properties: Properties.fromJson(json["properties"]),
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({
  "Feature": FeatureType.FEATURE
});