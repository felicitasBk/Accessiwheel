import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/domain/entities/feature.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/marker_popup_dialog_helper.dart';

class GeneralAccessibility extends StatelessWidget {
  final Feature location;

  const GeneralAccessibility({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MarkerPopupDialogHelper helper = MarkerPopupDialogHelper(location);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (helper.isWheelchairInfoAvailable())
          Text(
            location.properties.accessibility.accessibleWith?.wheelchair ??
                    false
                ? AppStrings.wheelchairAccessibleText
                : location.properties.accessibility.partiallyAccessibleWith
                            ?.wheelchair ??
                        false
                    ? AppStrings.partiallyWheelchairAccessibleText
                    : AppStrings.notWheelchairAccessibleText,
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        if (location.properties.accessibility.accessibleWith?.guideDog != null)
          Text(
            location.properties.accessibility.accessibleWith!.guideDog!
                ? AppStrings.guideDogAccessibleText
                : AppStrings.notGuideDogAccessibleText,
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
      ],
    );
  }
}
