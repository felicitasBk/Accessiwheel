/*
This class represent the entrance attribute of a restroom.
The "isLevel" property indicates whether the entrance to the restroom is level or not.
 */
import '../../common/utils/log.dart';

class AreaEntrance {
  bool isLevel;

  AreaEntrance({
    required this.isLevel,
  });

  factory AreaEntrance.fromJson(Map<String, dynamic> json) {
    try {
      return AreaEntrance(
        isLevel: json["isLevel"],
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}
