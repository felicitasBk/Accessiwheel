import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/domain/entities/accessibility.dart';

class MarkerPopupDialogOtherAccessibility extends StatelessWidget {
  final Accessibility accessibilityInfo;

  const MarkerPopupDialogOtherAccessibility({
    Key? key,
    required this.accessibilityInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (accessibilityInfo.hasMobilityService != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.mobilityServiceText,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              Flexible(
                child: Text(
                  accessibilityInfo.hasMobilityService!
                      ? AppStrings.hasMobilityServiceText
                      : AppStrings.noMobilityServiceText,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
              SizedBox(height: 8.0),
            ],
          ),

        if (accessibilityInfo.serviceContact != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.serviceContactText,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              Flexible(
                child: Text(
                  accessibilityInfo.serviceContact!,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
              SizedBox(height: 8.0),
            ],
          ),

        if (accessibilityInfo.staff?.isTrainedForDisabilities != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  accessibilityInfo.staff!.isTrainedForDisabilities
                      ? AppStrings.staffTrainedForDisabilitiesText
                      : AppStrings.staffNotTrainedForDisabilitiesText,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
            ],
          ),

        if (accessibilityInfo.animalPolicy?.allowsServiceAnimals != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  accessibilityInfo.animalPolicy!.allowsServiceAnimals
                      ? AppStrings.serviceAnimalsAllowedText
                      : AppStrings.serviceAnimalsNotAllowedText,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
