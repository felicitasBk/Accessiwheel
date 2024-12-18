import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/common/utils/log.dart';
import 'package:wheelmap/domain/entities/address.dart';
import 'package:wheelmap/domain/entities/description.dart';
import 'package:wheelmap/domain/entities/name.dart';
import 'package:wheelmap/domain/entities/properties.dart';

extension DescriptionExtension on Properties {
  String getDescription() {
    log.i('getDescription');
    if (descriptionString != null) {
      return descriptionString!;
    }
    if (description != null) {
      Description description = this.description!;
      if (description.de != null && description.de != '') {
        return description.de!;
      } else {
        return description.en!;
      }
    }
    return '';
  }
}

extension AddressExtension on Properties {
  String getAddress() {
    log.i('getAddress');
    if (addressString != null) {
      return addressString!;
    }
    if (address != null) {
      Address address = this.address!;
      if (address.text != null) {
        return address.text!;
      }
      dynamic street = address.getStreet() ?? '';
      dynamic postalCode = address.getPostalCode() ?? '';
      dynamic city = address.getCity() ?? '';
      String house = address.house ?? '';
      String state = address.state ?? '';
      String country = address.country ?? '';
      String countryCode = address.countryCode ?? '';
      return '$street $house $postalCode $city $state $country $countryCode';
    }
    return 'Not available';
  }
}

extension NameExtension on Properties {
  String getName() {
    log.d('getPropertyName');
    if (nameString != null) {
      return nameString!;
    }
    if (name != null) {
      Name name = this.name!;
      if (name.de != null && name.de != '') {
        return name.de!;
      } else {
        return name.en!;
      }
    }
    return AppStrings.noNameText;
  }
}
