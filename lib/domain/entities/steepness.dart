import '../../common/utils/log.dart';

class Steepness {
  int value;
  String percentage;

  Steepness({
    required this.value,
    required this.percentage,
  });

  factory Steepness.fromJson(Map<String, dynamic> json) {
    try {
      return Steepness(
        value: json["value"],
        percentage: json["percentage"],
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

    int get getValue {
      return value;
    }

    String get getPercentage {
      return percentage;
    }
}
