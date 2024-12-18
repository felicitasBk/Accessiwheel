import 'package:wheelmap/common/utils/log.dart';

// This class represents the address with various fields.
class Address {
  dynamic street;
  dynamic postalCode;
  dynamic city;
  String? state;
  String? country;
  String? countryCode;
  String? text;
  String? house;

  Address({
    this.street,
    this.postalCode,
    this.city,
    this.state,
    this.country,
    this.countryCode,
    this.text,
    this.house,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    try {
      return Address(
        street: json["street"],
        postalCode: json["postalCode"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        countryCode: json["countryCode"],
        text: json["text"],
        house: json["house"],
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  dynamic getStreet() {
    if (street is String) {
      return street;
    } else if (street is Map<String, dynamic>) {
      return street['de'];
    }
    return null;
  }

  dynamic getPostalCode() {
    if (postalCode is String) {
      return postalCode;
    } else if (postalCode is Map<String, dynamic>) {
      return postalCode['de'];
    }
    return null;
  }

  dynamic getCity() {
    if (city is String) {
      return city;
    } else if (city is Map<String, dynamic>) {
      return city['de'];
    }
    return null;
  }
}
