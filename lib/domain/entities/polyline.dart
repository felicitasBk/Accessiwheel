// this class represents a polyline, which is a sequence of connected line segments in a two-dimensional space.

import '../../common/utils/log.dart';

class Polyline {
  List<double> polyline;

  Polyline(this.polyline);

  double getLat() {
    return polyline[1];
  }

  double getLng() {
    return polyline[0];
  }

  factory Polyline.fromJson(List<double> json) {
    try {
      return Polyline(json);
    } catch (e) {
        log.e(e);
        rethrow;
    }
  }
}