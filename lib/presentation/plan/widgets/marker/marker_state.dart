import 'package:equatable/equatable.dart';
import 'package:wheelmap/domain/entities/nearest_location.dart';
import 'package:wheelmap/domain/entities/feature.dart';


class MarkerState with EquatableMixin {
  final Feature marker;
  bool isExpanded;
  bool isEntranceExpanded;
  bool isRestroomExpanded;
  bool isOtherExpanded;
  bool isNearestLocationsExpanded;
  Map<String, bool> locationExpandedMap; // Map to track expanded state of locations

  MarkerState({
    required this.marker,
    required this.isExpanded,
    required this.isEntranceExpanded,
    required this.isRestroomExpanded,
    required this.isOtherExpanded,
    required this.isNearestLocationsExpanded,
    required this.locationExpandedMap,
  });

  factory MarkerState.init(Feature marker){
    return MarkerState(
        marker: marker,
        isExpanded: false,
        isEntranceExpanded: false,
        isRestroomExpanded: false,
        isOtherExpanded: false,
        isNearestLocationsExpanded: false,
        locationExpandedMap: {},
    );
  }

  MarkerState copyWith({
    bool? isExpanded,
    bool? isEntranceExpanded,
    bool? isRestroomExpanded,
    bool? isOtherExpanded,
    bool? isNearestLocationsExpanded,
    Map<String, bool>? locationExpandedMap,
  }) {
    return MarkerState(
        marker: marker,
        isExpanded: isExpanded ?? this.isExpanded,
        isEntranceExpanded: isEntranceExpanded ?? this.isEntranceExpanded,
        isRestroomExpanded: isRestroomExpanded ?? this.isRestroomExpanded,
        isOtherExpanded: isOtherExpanded ?? this.isOtherExpanded,
        isNearestLocationsExpanded: isNearestLocationsExpanded ?? this.isNearestLocationsExpanded,
        locationExpandedMap: locationExpandedMap ?? this.locationExpandedMap
    );
  }

  @override
  List<Object> get props => [
    marker,
    isExpanded,
    isEntranceExpanded,
    isRestroomExpanded,
    isOtherExpanded,
    isNearestLocationsExpanded,
    locationExpandedMap,
  ];
}


