import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/domain/entities/feature.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/marker_popup_dialog_helper.dart';

class RestroomInfoView extends StatelessWidget {
  final Feature location;
  final MarkerPopupDialogHelper helper;

  const RestroomInfoView(
      {Key? key, required this.location, required this.helper})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (helper.isAreaRestroomsWheelchairInfoAvailable())
          Flexible(
            child: Text(
              location.properties.accessibility.getRestroomWheelchairAccessibleStatus(),
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ),
        if (helper.isAccessibilityRestroomsEntranceInfoAvailable())
          Row(
            children: [
              Text(
                AppStrings.restroomEntranceText,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
              Text(
                location.properties.accessibility.getRestroomEntranceLevel(),
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ],
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.toiletText,
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            Flexible(
              child: Text(
                helper.getToiletHandlesText(),
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
          ],
        ),
        if (helper.isAreaRestroomsShowerInfoAvailable())
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.showerText,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
              Flexible(
                child: Text(
                  helper.getShowerText(),
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
