import 'package:equatable/equatable.dart';
import 'package:wheelmap/common/enum/loading_status.dart';
import 'package:wheelmap/data/API/error_message.dart';
import 'package:wheelmap/domain/entities/feature.dart';
import 'package:wheelmap/domain/entities/instruction.dart';
import 'package:wheelmap/domain/entities/nearest_location.dart';
import 'package:wheelmap/domain/entities/polyline.dart';
import 'package:wheelmap/domain/entities/steepness.dart';
import 'package:wheelmap/domain/entities/surface.dart';

/// State file for Plan screen. Will hold all the ui states.
///
class PlanState with EquatableMixin {
  /// Hold lines
  List<Polyline> polyLines;
  List<Surface> surfaces;
  List<Steepness> steepness;
  List<Instruction> instructions;
  bool instructionExpanded = false;
  bool isShowingAltRoutes = false;

  /// Hold the loading status of the screen
  LoadingStatus loadingStatus;

  /// Hold the error message with description
  ErrorMessage? errorMessage;

  double rotation;

  List<Feature> featureMarkers;

  List<NearestLocation> nearestLocations;

  PlanState(
      {required this.polyLines,
      required this.surfaces,
      required this.steepness,
      required this.instructions,
      required this.loadingStatus,
      required this.errorMessage,
      required this.rotation,
      required this.featureMarkers,
      this.instructionExpanded = false,
      this.isShowingAltRoutes = false,
      required this.nearestLocations
      });

  factory PlanState.init() {
    return PlanState(
        polyLines: [],
        surfaces: [],
        steepness: [],
        instructions: [],
        loadingStatus: LoadingStatus.loading,
        errorMessage: null,
        rotation: 0.0,
        featureMarkers: [],
        nearestLocations: []);
  }

  PlanState copyWith(
      {List<Polyline>? polyLines,
      List<Surface>? surfaces,
      List<Steepness>? steepness,
      List<Instruction>? instructions,
      LoadingStatus? loadingStatus,
      ErrorMessage? errorMessage,
      double? rotation,
      List<Feature>? featureMarkers,
      bool? instructionExpanded,
      bool? isShowingAltRoutes,
      List<NearestLocation>? nearestLocations
    }) {
    return PlanState(
        polyLines: polyLines ?? this.polyLines,
        surfaces: surfaces ?? this.surfaces,
        steepness: steepness ?? this.steepness,
        instructions: instructions ?? this.instructions,
        loadingStatus: loadingStatus ?? this.loadingStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        rotation: rotation ?? this.rotation,
        featureMarkers: featureMarkers ?? this.featureMarkers,
        instructionExpanded: instructionExpanded ?? this.instructionExpanded,
        isShowingAltRoutes: isShowingAltRoutes ?? this.isShowingAltRoutes,
        nearestLocations:nearestLocations ?? this.nearestLocations
    );
  }

  @override
  List<Object?> get props => [
        polyLines,
        surfaces,
        steepness,
        instructions,
        loadingStatus,
        errorMessage,
        rotation,
        featureMarkers,
        instructionExpanded,
        isShowingAltRoutes,
        nearestLocations
      ];
}
