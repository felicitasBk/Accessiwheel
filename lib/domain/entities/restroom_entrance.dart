import '../../common/utils/log.dart';

class RestroomEntrance {
  bool isLevel;

  RestroomEntrance({
    required this.isLevel,
  });

  factory RestroomEntrance.fromJson(Map<String, dynamic> json) {
    try {
      return RestroomEntrance(
        isLevel: json["isLevel"],
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}