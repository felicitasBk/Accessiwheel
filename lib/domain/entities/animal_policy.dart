import '../../common/utils/log.dart';

class AnimalPolicy {
  bool allowsServiceAnimals;

  AnimalPolicy({
    required this.allowsServiceAnimals,
  });

  factory AnimalPolicy.fromJson(Map<String, dynamic> json) {
    try {
      return AnimalPolicy(
        allowsServiceAnimals: json["allowsServiceAnimals"],
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}