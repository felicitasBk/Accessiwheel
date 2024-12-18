import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheelmap/common/enum/loading_status.dart';
import 'package:wheelmap/common/utils/alert_dialog_manager.dart';
import 'package:wheelmap/common/utils/log.dart';
import 'package:wheelmap/data/API/error_message.dart';
import 'package:wheelmap/data/repositories/plan_repository.dart';
import 'package:wheelmap/domain/entities/feature.dart';
import 'package:wheelmap/domain/entities/instruction.dart';
import 'package:wheelmap/domain/entities/nearest_location.dart';
import 'package:wheelmap/domain/entities/polyline.dart';
import 'package:wheelmap/domain/entities/steepness.dart';
import 'package:wheelmap/domain/entities/surface.dart';
import 'package:wheelmap/presentation/plan/plan_state.dart';

/// Cubit file for the Plan screen. Will hold all the business logic.
///
class PlanCubit extends Cubit<PlanState> {
  final PlanRepository planRepository;
  final List<List<double>> selectedCoordinates; //these are actual coordinates, not hard-coded
  final BuildContext context;//here context is used for showing AlertDialog box
  PlanCubit(this.planRepository, this.selectedCoordinates, this.context) : super(PlanState.init());
  void init() async {
    try{
      await fetchMarkers(selectedCoordinates);
      await fetchPolyLines(selectedCoordinates);
    }
    catch(e){
      AlertDialogManager.singleButtonDialog(
        context,
        "Error",
        e.toString(),
            () {
          //will take user to the previous screen.
          Navigator.pop(context);
        },
      );
    }
  }

  /// TODO: - Check api and local call again.
  Future<void> fetchPolyLines(coordinates) async {
    log.d('fetchPolyLines');
    List<List<double>> filteredCoordinates = [];
    try {
      //making sure to send only correct coordinates
      //to the API to fetch the data
      // markers and polylines coordinates will be same with this
      for (var element in state.featureMarkers) {
        final coordinate = element.geometry.coordinate;
        filteredCoordinates.add([coordinate.longitude, coordinate.latitude]);
      }
      final routeData = await planRepository.getRouteData(filteredCoordinates);
      List<Polyline> polylines = routeData.polylines;
      List<Surface> surfaces = routeData.surfaces;
      List<Steepness> steepness = routeData.steepness;
      List<Instruction> instructions = routeData.instructions;
      emit(state.copyWith(
          polyLines: polylines,
          surfaces: surfaces,
          steepness: steepness,
          instructions: instructions,
          loadingStatus: LoadingStatus.loaded));
    } catch (e, stacktrace) {
      log.e(e);
      // ErrorMessage errorMessage = ErrorMessage(e.toString(), "Api error", 100);
      // emit(state.copyWith(errorMessage: errorMessage));
      throw('Something went wrong. Please check your internet connection or try again later.');
       
    }
  }

  /// Will fetch markers from API or local storage.
  Future<void> fetchMarkers(coordinates) async {
    log.d('fetchMarkers');
    try {

      //container for filteredMarkers
      List<Feature> filteredMarkers = [];

      //fetching filtered markers only
      filteredMarkers = await getFilteredMarkers(coordinates);

      emit(state.copyWith(featureMarkers: filteredMarkers, errorMessage: null));
    } catch (e) {
      log.e(e);
      ErrorMessage errorMessage = ErrorMessage(e.toString(), "Api error", 100);
      emit(state.copyWith(errorMessage: errorMessage));
      throw Exception('Error while fetching markers data locally');
    }
  }

  //This method compares given coordinates with all the coordinates
  // available in accessibility_data.json file
  // if given coordinates exists in accessibility_data.json file
  // it will add it into a new list and return.
  Future<List<Feature>> getFilteredMarkers(coordinates) async {
    List<Feature> filteredMarkers = [];
    try {
      //fetch all the markers data from accessibility_data.json file.
      final markers = await planRepository.getMarkersData();
      for (var coordinate in coordinates) {
        double lng = coordinate[0];
        double lat = coordinate[1];
        for (var marker in markers) {
          double markerLat = marker.geometry.coordinate.latitude;
          double markerLng = marker.geometry.coordinate.longitude;
          if (lat == markerLat && lng == markerLng) {
            filteredMarkers.add(marker);
            break;
          }
        }
      }
    }
    catch (e) {
      log.e(e);
      ErrorMessage errorMessage = ErrorMessage(e.toString(), "getFilteredMarkers error", 100);
      emit(state.copyWith(errorMessage: errorMessage));
      throw Exception('Error while filtering the markers data locally');
    }
    return filteredMarkers;
  }

  Future<List<Feature>?> fetchLocations() async {
    log.d('fetchLocations');
    try {
      return await planRepository.getMarkersData();
    } catch (e) {
      log.e(e);
      ErrorMessage errorMessage = ErrorMessage(e.toString(), "Api error", 100);
      emit(state.copyWith(errorMessage: errorMessage));
    }
  }

  void updateInstructionExpanded(bool instructionExpanded) {
    log.d('toggleInstructionExpanded');
    try {
      emit(state.copyWith(instructionExpanded: instructionExpanded));
    } catch (e) {
      log.e(e);
      ErrorMessage errorMessage = ErrorMessage(e.toString(), "Api error", 100);
      emit(state.copyWith(errorMessage: errorMessage));
    }
  }

  String secondsToMinutes({required int time}) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min mins" : "$min mins";
    String second = sec.toString().length <= 1 ? " 0$sec secs" : " $sec secs";
    minute = (min > 0) ? minute : "";
    return "$minute$second";
  }

  Future<void> fetchNearestLocations(Feature marker) async {
    final features = await fetchLocations();
    final locations = await NearestLocation(
      distance: 0,
      type: marker.type,
      geometry: marker.geometry,
      properties: marker.properties,
    ).findNearestLocations(
      features,
      marker,
      10,
    );

    emit(state.copyWith(nearestLocations: locations));
  }

  Future<void> updateRoute(Feature feature, NearestLocation location) async {
    log.i('updateRoute');
    emit(
      state.copyWith(loadingStatus: LoadingStatus.loading),
    );

    ///TODO: - Add try catch and error handling here.
    
    var originalFeatureMarkers = [...state.featureMarkers];
    var featureMarkers = [...state.featureMarkers];
    var isShowingAltRoutes = true;
    var markerIndex = featureMarkers.indexOf(feature);
    featureMarkers[markerIndex] = location;
    try{
       emit(state.copyWith(
        featureMarkers: featureMarkers));
      await fetchPolyLines(selectedCoordinates);
    }catch(e){
      log.d(e.toString());
      featureMarkers = originalFeatureMarkers;
      isShowingAltRoutes = false;
      AlertDialogManager.singleButtonDialog(
        context,
        "Error",
        'Error getting data for this alternative location. Please choose another one.',
        () {},
      );

    }
    
    emit(state.copyWith(
        featureMarkers: featureMarkers,
        errorMessage: null,
        loadingStatus: LoadingStatus.loaded,
        isShowingAltRoutes: isShowingAltRoutes));
    
  }
}
