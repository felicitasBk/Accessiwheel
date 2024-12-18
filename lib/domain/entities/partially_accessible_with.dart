// this class represents partial accessibility information for a certain feature.
import '../../common/utils/log.dart';

class PartiallyAccessibleWith {
  bool wheelchair;

  PartiallyAccessibleWith({
    required this.wheelchair,
  });

  factory PartiallyAccessibleWith.fromJson(Map<String, dynamic> json) {
    try {
      return PartiallyAccessibleWith(
        wheelchair: json["wheelchair"],
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}