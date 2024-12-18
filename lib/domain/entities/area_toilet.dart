import 'package:wheelmap/domain/entities/foldable_handles.dart';

import '../../common/utils/log.dart';

class AreaToilet {
  FoldableHandles? foldableHandles;

  AreaToilet({
    this.foldableHandles,
  });

  factory AreaToilet.fromJson(Map<String, dynamic> json) {
    try {
      return AreaToilet(
        foldableHandles: FoldableHandles.fromJson(json["foldableHandles"]),
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}