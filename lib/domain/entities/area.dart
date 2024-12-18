import 'package:wheelmap/domain/entities/area_entrance.dart';
import 'package:wheelmap/domain/entities/area_rest_room.dart';

import '../../common/utils/log.dart';

//This class represents area with multiple restrooms and entrances.
class Area {
  List<AreaEntrance>? entrances;
  List<AreaRestroom> restrooms;

  Area({
    this.entrances,
    required this.restrooms,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    try {
      return Area(
            restrooms: List<AreaRestroom>.from(json["restrooms"].map((x) => AreaRestroom.fromJson(x))),
            entrances: json["entrances"] == null ? [] : List<AreaEntrance>.from(json["entrances"]!.map((x) => AreaEntrance.fromJson(x))),
          );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}
