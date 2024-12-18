import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/common/utils/log.dart';
import 'package:wheelmap/domain/entities/accessibility_entrance.dart';
import 'package:wheelmap/domain/entities/accessibility_restroom.dart';
import 'package:wheelmap/domain/entities/accessible_with.dart';
import 'package:wheelmap/domain/entities/animal_policy.dart';
import 'package:wheelmap/domain/entities/area.dart';
import 'package:wheelmap/domain/entities/partially_accessible_with.dart';
import 'package:wheelmap/domain/entities/staff.dart';
import 'package:wheelmap/domain/entities/stair.dart';

// Model object for the accessibility api .
//The class Accessibility represents the accessibility information for a particular location or area.
class Accessibility {
  AccessibleWith? accessibleWith;
  List<Area>? areas;
  PartiallyAccessibleWith? partiallyAccessibleWith;
  List<AccessibilityEntrance>? entrances;
  List<AccessibilityRestroom>? restrooms;
  Staff? staff;
  bool? hasMobilityService;
  String? serviceContact;
  AnimalPolicy? animalPolicy;

  Accessibility({
    this.accessibleWith,
    this.areas,
    this.partiallyAccessibleWith,
    this.entrances,
    this.restrooms,
    this.staff,
    this.hasMobilityService,
    this.serviceContact,
    this.animalPolicy,
  });

  factory Accessibility.fromJson(Map<String, dynamic> json) {
    try {
      return Accessibility(
        accessibleWith: json["accessibleWith"] == null
            ? null
            : AccessibleWith.fromJson(json["accessibleWith"]),
        areas: json["areas"] == null
            ? []
            : List<Area>.from(json["areas"]!.map((x) => Area.fromJson(x))),
        partiallyAccessibleWith: json["partiallyAccessibleWith"] == null
            ? null
            : PartiallyAccessibleWith.fromJson(json["partiallyAccessibleWith"]),
        entrances: json["entrances"] == null
            ? []
            : List<AccessibilityEntrance>.from(json["entrances"]!
                .map((x) => AccessibilityEntrance.fromJson(x))),
        restrooms: json["restrooms"] == null
            ? []
            : List<AccessibilityRestroom>.from(json["restrooms"]!
                .map((x) => AccessibilityRestroom.fromJson(x))),
        staff: json["staff"] == null ? null : Staff.fromJson(json["staff"]),
        hasMobilityService: json["hasMobilityService"],
        serviceContact: json["serviceContact"]?.toString(),
        animalPolicy: json["animalPolicy"] == null
            ? null
            : AnimalPolicy.fromJson(json["animalPolicy"]),
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  //TODO:- Move this methods to a extension class later.

  bool isShowerWalkIn() {
    List<Area> areas = this.areas ?? [];
    return areas.any((area) =>
        area.restrooms.any((restroom) => restroom.shower?.isWalkIn == true));
  }

  bool showerHasSupportRails() {
    List<Area> areas = this.areas ?? [];
    return areas.any((area) => area.restrooms
        .any((restroom) => restroom.shower?.hasSupportRails == true));
  }

  bool isEntranceLevel() {
    List<Area> areas = this.areas ?? [];
    return areas.any((area) =>
        area.entrances?.any((entrance) => entrance.isLevel == true) ?? false);
  }

  String getEntranceRampText() {
    if (this.entrances == null || (this.entrances ?? []).isEmpty) {
      return "";
    }
    List<AccessibilityEntrance> entrances = this.entrances ?? [];
    return entrances.any((entrance) => entrance.hasFixedRamp == true)
        ? "Has fixed ramp"
        : "No fixed ramp";
  }

  String getDoorStatusText() {
    if (this.entrances == null || (this.entrances ?? []).isEmpty) {
      return "";
    }
    List<AccessibilityEntrance> entrances = this.entrances ?? [];
    bool isAutomaticOrAlwaysOpen = entrances.any((entrance) =>
        entrance.doors?.any((door) => door.isAutomaticOrAlwaysOpen == true) ??
        false);
    return isAutomaticOrAlwaysOpen ? "Automatic/Always open entrance door" : "";
  }

  int getStairsCount() {
    List<AccessibilityEntrance> entrances = this.entrances ?? [];
    int totalStairs = 0;

    for (AccessibilityEntrance entrance in entrances) {
      List<Stair>? stairs = entrance.stairs;
      if (stairs != null) {
        for (Stair stair in stairs) {
          totalStairs += stair.count;
        }
      }
    }

    return totalStairs;
  }

  String getRestroomWheelchairAccessibleStatus() {
    List<Area> areas = this.areas ?? [];
    bool isWheelChairAccessible = areas.any((area) => area.restrooms
        .any((restroom) => restroom.isAccessibleWithWheelchair == true));
    return isWheelChairAccessible
        ? AppStrings.wheelchairAccessibleText
        : AppStrings.notWheelchairAccessibleText;
  }

  String getRestroomEntranceLevel() {
    List<AccessibilityRestroom> restrooms = this.restrooms ?? [];
    bool hasEntranceLevel =
        restrooms.any((restroom) => restroom.entrance?.isLevel == true);
    return hasEntranceLevel
        ? AppStrings.isLevelText
        : AppStrings.isNotLevelText;
  }
}
