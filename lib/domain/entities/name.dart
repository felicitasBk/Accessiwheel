import 'package:wheelmap/common/utils/log.dart';

// This class represents the name of an object, with language codes  specified as string keys and corresponding values.


class Name {
  String? de;
  String? en;

  Name({
  this.de,
  this.en,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    try {
      return Name(
        de: json["de"],
        en: json["en"],
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

}
