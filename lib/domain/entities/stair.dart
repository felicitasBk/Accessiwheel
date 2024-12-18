import 'package:wheelmap/domain/entities/step_height.dart';

import '../../common/utils/log.dart';

class Stair {
  int count;
  StepHeight? stepHeight;

  Stair({
    required this.count,
    this.stepHeight,
  });

  factory Stair.fromJson(Map<String, dynamic> json) {
    try {
      return Stair(
        count: json["count"],
        stepHeight: json["stepHeight"] == null
            ? null
            : StepHeight.fromJson(json["stepHeight"]),
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  String? getStepHeight() {
    StepHeight? stepHeight = this.stepHeight;
    if (stepHeight != null) {
      return "${stepHeight.value} ${stepHeight.unit}";
    }
    return null;
  }
}
