import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/domain/entities/accessibility.dart';
import 'package:wheelmap/domain/entities/accessibility_entrance.dart';
import 'package:wheelmap/domain/entities/accessibility_restroom.dart';
import 'package:wheelmap/domain/entities/area.dart';
import 'package:wheelmap/domain/entities/area_rest_room.dart';
import 'package:wheelmap/domain/entities/feature.dart';
import 'package:wheelmap/domain/entities/stair.dart';

class MarkerPopupDialogHelper {
  Feature location;

  MarkerPopupDialogHelper(this.location);

  bool isDescriptionAvailable() =>
      location.properties.description != null ||
      (location.properties.descriptionString != null &&
          location.properties.descriptionString != '');

  bool isWheelchairInfoAvailable() =>
      location.properties.accessibility.accessibleWith?.wheelchair != null ||
      location.properties.accessibility.partiallyAccessibleWith != null;

  bool isAreasInfoAvailable() =>
      (location.properties.accessibility.areas != null &&
          location.properties.accessibility.areas!.isNotEmpty);
  bool isAreasEntrancesInfoAvailable() =>
      isAreasInfoAvailable() &&
      location.properties.accessibility.areas!
          .any((area) => area.entrances != null || area.entrances!.isNotEmpty);
  bool isAreasRestroomsInfoAvailable() =>
      isAreasInfoAvailable() &&
      location.properties.accessibility.areas!
          .any((area) => area.restrooms.isNotEmpty);

  bool isEntrancesInfoAvailable() =>
      isAccessibilityEntrancesInfoAvailable() ||
      isAreasEntrancesInfoAvailable();
  bool isRestroomsInfoAvailable() =>
      isAccessibilityRestroomsInfoAvailable() ||
      isAreasRestroomsInfoAvailable();

  bool isAreaRestroomsFacilityInfoAvailable(
      bool Function(AreaRestroom) condition) {
    return isAreasInfoAvailable() &&
        location.properties.accessibility.areas!
            .any((area) => area.restrooms.any(condition));
  }

  bool isAreaRestroomsWheelchairInfoAvailable() =>
      isAreaRestroomsFacilityInfoAvailable(
          (restroom) => restroom.isAccessibleWithWheelchair != null);
  bool isAreaRestroomsToiletInfoAvailable() =>
      isAreaRestroomsFacilityInfoAvailable(
          (restroom) => restroom.toilet != null);
  bool isAreaRestroomsShowerInfoAvailable() =>
      isAreaRestroomsFacilityInfoAvailable(
          (restroom) => restroom.shower != null);

  bool isAccessibilityEntrancesInfoAvailable() =>
      (location.properties.accessibility.entrances != null &&
          location.properties.accessibility.entrances!.isNotEmpty);
  bool isAccessibilityRestroomsInfoAvailable() =>
      (location.properties.accessibility.restrooms != null &&
          location.properties.accessibility.restrooms!.isNotEmpty);

  bool isAccessibilityRestroomsFacilityInfoAvailable(
      bool Function(AccessibilityRestroom) condition) {
    return isAccessibilityRestroomsInfoAvailable() &&
        location.properties.accessibility.restrooms!.any(condition);
  }

  bool isAccessibilityRestroomsEntranceInfoAvailable() =>
      isAccessibilityRestroomsFacilityInfoAvailable(
          (restroom) => restroom.entrance != null);
  bool isAccessibilityRestroomsToiletInfoAvailable() =>
      isAccessibilityRestroomsFacilityInfoAvailable(
          (restroom) => restroom.toilet != null);

  bool isPhoneNumberInfoAvailable() =>
      location.properties.phoneNumber != null &&
      location.properties.phoneNumber != "";
  bool isPlaceWebsiteUrlInfoAvailable() =>
      location.properties.placeWebsiteUrl != null &&
      location.properties.placeWebsiteUrl != "";

  String getToiletHandlesText() {
    Accessibility accessibility = location.properties.accessibility;
    final handlesFoldable = areToiletHandlesFoldable(accessibility);
    final onLeftSide = handlesFoldable['onUsersLeftSide'] ?? false;
    final onRightSide = handlesFoldable['onUsersRightSide'] ?? false;
    final onOneSide = handlesFoldable['onAtLeastOneSide'] ?? false;
    String text = '';

    if (handlesFoldable['hasFoldingHandles'] ?? false) {
      if (onLeftSide) {
        text += AppStrings.foldableHandlesOnLeftSideText;
        if (onRightSide) {
          text += ', ';
        }
      }
      if (onRightSide) {
        text += AppStrings.foldableHandlesOnRightSideText;
      }
    } else {
      text = onOneSide
          ? AppStrings.foldableHandlesOnOneSideText
          : AppStrings.noFoldableHandlesText;
    }

    return text;
  }

  Map<String, bool> areToiletHandlesFoldable(Accessibility accessibility) {
    bool hasFoldingHandles = false;
    bool onUsersLeftSide = false;
    bool onUsersRightSide = false;

    List<AccessibilityRestroom> accessibilityRestrooms =
        accessibility.restrooms ?? [];
    for (var restroom in accessibilityRestrooms) {
      if (restroom.toilet?.hasFoldingHandles == true) {
        hasFoldingHandles = true;
        if (restroom.toilet?.foldingHandles?.onUsersLeftSide == true) {
          onUsersLeftSide = true;
        }
        if (restroom.toilet?.foldingHandles?.onUsersRightSide == true) {
          onUsersRightSide = true;
        }
      }
    }

    List<Area> areas = accessibility.areas ?? [];
    bool onAtLeastOneSide = areas.expand((area) => area.restrooms).any(
        (restroom) =>
            restroom.toilet?.foldableHandles?.onAtLeastOneSide == true);

    return {
      'hasFoldingHandles': hasFoldingHandles,
      'onUsersLeftSide': onUsersLeftSide,
      'onUsersRightSide': onUsersRightSide,
      'onAtLeastOneSide': onAtLeastOneSide
    };
  }

  String getShowerText() {
    Accessibility accessibility = location.properties.accessibility;
    final isWalkIn = accessibility.isShowerWalkIn();
    final hasSupportRails = accessibility.showerHasSupportRails();
    String text = '';

    if (isWalkIn) {
      text += AppStrings.isWalkinText;
      if (hasSupportRails) {
        text += ', ';
      }
    }
    if (hasSupportRails) {
      text += AppStrings.hasSupportRailsText;
    }

    return text;
  }

  String getAccessibilityEntrancesText() {
    Accessibility accessibility = location.properties.accessibility;
    List<Area>? areas = accessibility.areas;
    List<AccessibilityEntrance>? entrances = accessibility.entrances;

    // Check if entrance is level
    String levelText = areas == null || areas.isEmpty
        ? ""
        : accessibility.isEntranceLevel()
            ? "Level"
            : "Not level";

    // Check if entrance has a fixed ramp
    String rampText = accessibility.getEntranceRampText();

    // Check if entrance door is automatic or always open
    String doorText = accessibility.getDoorStatusText();
    // Get stairs information
    String stairsText =
        entrances == null || entrances.isEmpty ? "" : getStairsText();

    List<String> entrancesText = [];

    if (levelText.isNotEmpty) {
      entrancesText.add(levelText);
    }
    if (rampText.isNotEmpty) {
      entrancesText.add(rampText);
    }
    if (doorText.isNotEmpty) {
      entrancesText.add(doorText);
    }
    if (stairsText.isNotEmpty) {
      entrancesText.add(stairsText);
    }

    return entrancesText.join(", ");
  }

  String getStairsText() {
    Accessibility accessibility = location.properties.accessibility;
    List<AccessibilityEntrance> entrances = accessibility.entrances ?? [];

    for (AccessibilityEntrance entrance in entrances) {
      if (entrance.stairs != null) {
        int totalStairs = accessibility.getStairsCount();
        String stairsText = "$totalStairs stair(s)";

        for (AccessibilityEntrance entrance in entrances) {
          List<Stair>? stairs = entrance.stairs;
          if (stairs != null) {
            for (Stair stair in stairs) {
              String? stepHeight = stair.getStepHeight();
              if (stepHeight != null) {
                stairsText += " (Step height: $stepHeight)";
              }
            }
          }
        }

        return stairsText;
      }
    }

    return "Stairs information not available";
  }
}
