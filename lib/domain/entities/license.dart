/* This class represents the Licenses with properties including Id and name of the license, abbreviation of the license,
URL of the license's website, optional URL to the full text of the license, how the license is considered and
  organization associated with the license*/

import '../../common/utils/log.dart';

class License {
  String id;
  String name;
  String shortName;
  String websiteUrl;
  String? fullTextUrl;
  String consideredAs;
  String organizationId;

  License({
    required this.id,
    required this.name,
    required this.shortName,
    required this.websiteUrl,
    this.fullTextUrl,
    required this.consideredAs,
    required this.organizationId,
  });

  factory License.fromJson(Map<String, dynamic> json) {
    try {
      return License(
          id: json["_id"],
          name: json["name"],
          shortName: json["shortName"],
          websiteUrl: json["websiteURL"],
          fullTextUrl: json["fullTextURL"],
          consideredAs: json["consideredAs"],
          organizationId: json["organizationId"],
        );
      } catch (e) {
        log.e(e);
        rethrow;
      }
  }
}
