import 'package:wheelmap/domain/entities/license.dart';

import '../../common/utils/log.dart';


/* Related object provides details about different licenses, including their names,
URLs, classification, and associated organizations.
It provides methods to convert instances of the class to and from JSON format*/


class Related {
  Map<String, License> licenses;

  Related({
    required this.licenses,
  });

  factory Related.fromJson(Map<String, dynamic> json) {
    try {
      return Related(
        licenses: Map.from(json["licenses"])
            .map((k, v) => MapEntry<String, License>(k, License.fromJson(v))),
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}
