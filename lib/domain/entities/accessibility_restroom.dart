import 'package:wheelmap/domain/entities/accessibility_toilet.dart';
import 'package:wheelmap/domain/entities/area_entrance.dart';
import 'package:wheelmap/domain/entities/wash_basin.dart';

import '../../common/utils/log.dart';

class AccessibilityRestroom {
  AreaEntrance? entrance;
  AccessibilityToilet? toilet;
  WashBasin? washBasin;

  AccessibilityRestroom({
    this.entrance,
    this.toilet,
    this.washBasin,
  });

  factory AccessibilityRestroom.fromJson(Map<String, dynamic> json) {
    try {
      return AccessibilityRestroom(
        entrance: json["entrance"] == null ? null : AreaEntrance.fromJson(json["entrance"]),
        toilet: json["toilet"] == null ? null : AccessibilityToilet.fromJson(json["toilet"]),
        washBasin: json["washBasin"] == null ? null : WashBasin.fromJson(json["washBasin"]),
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}