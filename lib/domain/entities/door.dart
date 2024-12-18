import '../../common/utils/log.dart';

class Door {
  bool isAutomaticOrAlwaysOpen;

  Door({
    required this.isAutomaticOrAlwaysOpen,
  });

  factory Door.fromJson(Map<String, dynamic> json) =>
      Door(
        isAutomaticOrAlwaysOpen: json["isAutomaticOrAlwaysOpen"] ?? false,
      );

  Map<String, dynamic> toJson() {
    try {
      return {
        "isAutomaticOrAlwaysOpen": isAutomaticOrAlwaysOpen,
      };
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}