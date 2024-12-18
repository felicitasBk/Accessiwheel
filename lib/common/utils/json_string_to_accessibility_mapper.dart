import 'dart:convert';

import 'package:wheelmap/domain/entities/accessibility.dart';

//TODO: - Unfinished, finish later..
mixin JsonStringToAccessibilityMapper {
  Accessibility mapStringToAccessibility(String response) {
    final dynamic responseData = json.decode(response);
    return Accessibility.fromJson(responseData);
  }
}
