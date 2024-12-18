import 'package:wheelmap/domain/entities/folding_handles.dart';

import '../../common/utils/log.dart';

class AccessibilityToilet {
  bool? hasFoldingHandles;
  FoldingHandles? foldingHandles;

  AccessibilityToilet({
    this.hasFoldingHandles,
    this.foldingHandles,
  });

  factory AccessibilityToilet.fromJson(Map<String, dynamic> json) {
    try {
      return AccessibilityToilet(
        hasFoldingHandles: json["hasFoldingHandles"] ?? false,
        foldingHandles: json["foldingHandles"] == null ? null : FoldingHandles.fromJson(json["foldingHandles"]),
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}