import 'package:wheelmap/common/utils/log.dart';

// This class represents the name of an object, with language codes  specified as string keys and corresponding values.


class Description {
  String? de;
  String? en;

  Description({
  this.de,
  this.en,
  });

  factory Description.fromJson(Map<String, dynamic> json) {
    try {
      return Description(
        de: json["de"],
        en: json["en"],
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

}
