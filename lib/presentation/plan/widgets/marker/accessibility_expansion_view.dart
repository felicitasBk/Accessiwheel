import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/domain/entities/feature.dart';
import 'package:wheelmap/presentation/plan/widgets/expansion_view/expandable_view.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/general_accessibility.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/marker_popup_dialog_heading_text.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/marker_popup_dialog_helper.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/marker_popup_dialog_other_accessibility.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/restroom_info_view.dart';

class AccessibilityExpansionView extends StatelessWidget {
  final Feature location;

  const AccessibilityExpansionView({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: ExpandableView(
        header: MarkerPopupDialogHeadingText(
            headingText: AppStrings.accessibilityDetailsText, isBold: true),
        children: [
          GeneralAccessibility(location: location),
          _buildEntrancesSubMenu(location),
          SizedBox(height: 8.0),
          _buildRestroomsSubMenu(location),
          SizedBox(height: 8.0),
          _buildOtherSubMenu(location),
        ],
      ),
    );
  }

  Widget _buildEntrancesSubMenu(Feature location) {
    MarkerPopupDialogHelper helper = MarkerPopupDialogHelper(location);
    return ExpandableView(
      header: MarkerPopupDialogHeadingText(
          headingText: AppStrings.entrancesText, isBold: false),
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Flexible(
            child: Text(
              helper.getAccessibilityEntrancesText(),
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ),
        ]),
      ],
    );
  }

  Widget _buildRestroomsSubMenu(Feature location) {
    MarkerPopupDialogHelper helper = MarkerPopupDialogHelper(location);
    return ExpandableView(
      header: MarkerPopupDialogHeadingText(
          headingText: AppStrings.restroomsText, isBold: false),
      children: [
        RestroomInfoView(
          location: location,
          helper: helper,
        )
      ],
    );
  }

  Widget _buildOtherSubMenu(Feature location) {
    return ExpandableView(
      header: MarkerPopupDialogHeadingText(
          headingText: AppStrings.othersText, isBold: false),
      children: [
        MarkerPopupDialogOtherAccessibility(
          accessibilityInfo: location.properties.accessibility,
        )
      ],
    );
  }
}
