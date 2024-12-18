import 'package:flutter/material.dart';
import 'package:wheelmap/common/utils/log.dart';
import 'package:wheelmap/domain/entities/nearest_location.dart';
import 'package:wheelmap/domain/entities/properties_extension.dart';

class NearestLocationOverview extends StatelessWidget {
  final NearestLocation location;
  Function? onTapLocation;

  NearestLocationOverview({
    Key? key,
    required this.location,
    required this.onTapLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 8.0, right: 0, top: 4.0, bottom: 4.0),
      horizontalTitleGap: 0,
      title: Text(
        location.properties.getName(),
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        'Distance: ${location.getDistance()}',
      ),
      onTap: () {
        log.i('On tap NearestLocationOverview');
        if (onTapLocation != null) {
          onTapLocation!(location.properties.id);
        }
      },
    );
  }
}
