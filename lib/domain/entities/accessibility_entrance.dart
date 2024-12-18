import 'package:wheelmap/domain/entities/door.dart';
import 'package:wheelmap/domain/entities/stair.dart';

import '../../common/utils/log.dart';

class AccessibilityEntrance {
  bool? hasFixedRamp;
  List<Door>? doors;
  List<Stair>? stairs;

  AccessibilityEntrance({
    this.hasFixedRamp,
    this.stairs,
    this.doors,
  });

  factory AccessibilityEntrance.fromJson(Map<String, dynamic> json) {
    try {
      return AccessibilityEntrance(
        hasFixedRamp: json["hasFixedRamp"],
        doors: json["doors"] == null ? [] : List<Door>.from(
            json["doors"]!.map((x) => Door.fromJson(x))),
        stairs: json["stairs"] == null ? [] : List<Stair>.from(
            json["stairs"]!.map((x) => Stair.fromJson(x))),
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}