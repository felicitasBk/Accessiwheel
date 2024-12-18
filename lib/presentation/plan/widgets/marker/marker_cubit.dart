import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheelmap/domain/entities/feature.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/marker_state.dart';

class MarkerCubit extends Cubit<MarkerState> {
  MarkerCubit(Feature marker) : super(MarkerState.init(marker));

  void toggleExpanded(bool isExpanded) {
    emit(state.copyWith(isExpanded: isExpanded));
  }

  void toggleEntranceExpanded(bool isEntranceExpanded) {
    emit(state.copyWith(isEntranceExpanded: isEntranceExpanded));
  }

  void toggleRestroomExpanded(bool isRestroomExpanded) {
    emit(state.copyWith(isRestroomExpanded: isRestroomExpanded));
  }

  void toggleOtherExpanded(bool isOtherExpanded) {
    emit(state.copyWith(isOtherExpanded: isOtherExpanded));
  }

  void toggleNearestLocationsExpanded(bool isNearestLocationsExpanded) {
    emit(
        state.copyWith(isNearestLocationsExpanded: isNearestLocationsExpanded));
  }

  void toggleLocationExpanded(String locationId, bool isExpanded) {
    final updatedLocationExpandedMap = {
      ...state.locationExpandedMap,
      locationId: isExpanded,
    };
    emit(state.copyWith(locationExpandedMap: updatedLocationExpandedMap));
  }
}
