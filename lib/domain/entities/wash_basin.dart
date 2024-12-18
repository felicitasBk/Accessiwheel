import '../../common/utils/log.dart';

class WashBasin {
  WashBasin();

  factory WashBasin.fromJson(Map<String, dynamic> json) {
    try {
      return WashBasin();
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}