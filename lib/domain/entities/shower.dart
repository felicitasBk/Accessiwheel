import '../../common/utils/log.dart';

class Shower {
  bool isWalkIn;
  bool hasSupportRails;

  Shower({
    required this.isWalkIn,
    required this.hasSupportRails,
  });

  factory Shower.fromJson(Map<String, dynamic> json) {
    try {
      return Shower(
        isWalkIn: json["isWalkIn"],
        hasSupportRails: json["hasSupportRails"],
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}
