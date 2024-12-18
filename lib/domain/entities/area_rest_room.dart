
import 'package:wheelmap/domain/entities/restroom_entrance.dart';
import 'package:wheelmap/domain/entities/shower.dart';
import 'package:wheelmap/domain/entities/area_toilet.dart';

import '../../common/utils/log.dart';

/* This class represents a restroom and has one property:
isAccessibleWithWheelchair, which indicates whether the restroom is accessible with a wheelchair or not. */


class AreaRestroom {
  bool? isAccessibleWithWheelchair;
  AreaToilet? toilet;
  Shower? shower;

  AreaRestroom({
    this.isAccessibleWithWheelchair,
    this.toilet,
    this.shower,
    // this.entrance
  });

  factory AreaRestroom.fromJson(Map<String, dynamic> json) {
    try {
      return AreaRestroom(
        isAccessibleWithWheelchair: json["isAccessibleWithWheelchair"],
        toilet: json["toilet"] == null ? null : AreaToilet.fromJson(json["toilet"]),
        shower: json["shower"] == null ? null : Shower.fromJson(json["shower"]),
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}
