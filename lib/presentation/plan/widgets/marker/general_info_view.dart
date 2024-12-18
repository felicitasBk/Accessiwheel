import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/domain/entities/feature.dart';
import 'package:wheelmap/domain/entities/properties_extension.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/marker_popup_dialog_helper.dart';

class GeneralInfoView extends StatelessWidget {
  final Feature location;
  final double leftPadding;
  final bool isAddressShown;

  const GeneralInfoView(
      {Key? key,
      required this.location,
      required this.leftPadding,
      required this.isAddressShown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MarkerPopupDialogHelper helper = MarkerPopupDialogHelper(location);

    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAddressShown)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.addressText,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  location.properties.getAddress(),
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          helper.isDescriptionAvailable()
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.descriptionText,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        location.properties.getDescription(),
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
