
// This class represents the wheelchair and guidedog accessibility information associated with a location.

import '../../common/utils/log.dart';

class AccessibleWith {
  bool? wheelchair;
  bool? guideDog;

  AccessibleWith({
    this.wheelchair,
    this.guideDog,
  });

  factory AccessibleWith.fromJson(Map<String, dynamic> json) {
    try {
      return AccessibleWith(
            wheelchair: json["wheelchair"],
            guideDog: json["guideDog"],
          );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}
