import '../../common/utils/log.dart';

class Staff {
  bool isTrainedForDisabilities;

  Staff({
    required this.isTrainedForDisabilities,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    try {
      return Staff(
        isTrainedForDisabilities: json["isTrainedForDisabilities"],
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}