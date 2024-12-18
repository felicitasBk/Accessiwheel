
import '../../common/utils/log.dart';

class StepHeight {
  String unit;
  int value;

  StepHeight({
    required this.unit,
    required this.value,
  });

  factory StepHeight.fromJson(Map<String, dynamic> json) {
    try {
      return StepHeight(
        unit: json["unit"],
        value: json["value"],
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}