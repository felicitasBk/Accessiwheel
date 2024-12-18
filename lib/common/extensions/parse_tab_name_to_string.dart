import 'package:wheelmap/common/constants/app_constants.dart';

extension ParseTabNameToString on TabName {
  String capitalize() {
    String name = this.name;
    return "${name[0].toUpperCase()}${name.substring(1).toLowerCase()}";
  }
}
