import '../../common/utils/log.dart';

class FoldableHandles {
  bool? onAtLeastOneSide;

  FoldableHandles({
    this.onAtLeastOneSide,
  });

  factory FoldableHandles.fromJson(Map<String, dynamic> json) {
    try {
      return FoldableHandles(
        onAtLeastOneSide: json["onAtLeastOneSide"],
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}
