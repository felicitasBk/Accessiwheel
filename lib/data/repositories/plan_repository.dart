import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:wheelmap/common/constants/app_constants.dart';
import 'package:wheelmap/common/constants/route_instructions_type.dart';
import 'package:wheelmap/common/constants/route_steepness_percent.dart';
import 'package:wheelmap/common/constants/app_surfaces_names.dart';
import 'package:wheelmap/domain/entities/feature.dart';
import 'package:wheelmap/domain/entities/instruction.dart';
import 'package:wheelmap/domain/entities/ors_entities.dart';
import 'package:wheelmap/domain/entities/polyline.dart';
import 'package:wheelmap/domain/entities/steepness.dart';
import 'package:wheelmap/domain/entities/surface.dart';
import 'package:wheelmap/domain/repositoriy_interfaces/plan_repository_interface.dart';

// TODO: - Refactor needed.
/// There will be remote data source and
/// local data source for API and Locally stored data.
/// Repository will not access network/local storage directly.
///
class PlanRepository extends PlanRepositoryInterface {
  //TODO: - Need to refactor the parameter.
  /// List of List is complex, instead use something simple..
  /// API access will be taken to RemoteDataSource.
  /// Fetch poly lines from the remote
  @override
  Future<OpenRouteServiceEntities> getRouteData(
      List<List<double>> coordinates) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = openRouteServiceURL;
    final uri = Uri.parse(url);
    
    final response = await http.post(uri,
        body: jsonEncode({
          'coordinates': coordinates,
          "extra_info": ["surface", "steepness"]
        }),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final coordinates = json['features'][0]['geometry']['coordinates'];
      List<Polyline> polylines = coordinates.map<Polyline>((e) {
        Polyline coordinate = Polyline(e.cast<double>());
        return coordinate;
      }).toList();
      final properties = json['features'][0]['properties']['extras'];
      final surfaces = properties['surface']['summary'];

      final steepness = properties['steepness']['values'];
      final segments = json['features'][0]['properties']['segments'];

      List<Surface> surfacesObj = surfaces.map<Surface>((e) {
        double value = e['value'];
        Surface surface = Surface(image: appSurfacesImages[value.toInt()] ?? '', percentage: e['amount'], name: appSurfacesNames[value.toInt()] ?? '');
        return surface;
      }).toList();
      List<Steepness> steepnessObj = steepness.map<Steepness>((e) {
        int value = e[2];
        Steepness steepness = Steepness(value: value.toInt(), percentage: routeSteepnessPercent[value.toInt()] ?? '');
        return steepness;
      }).toList();
      List<Instruction> instructions = [];
      
      segments.forEach((segment) {
        segment['steps'].forEach((step){
          String type = routeInstructionsType[step['type']].toString();
          IconData icon = routeInstructionsIcons[step['type']] ?? Icons.straight;
          Instruction instruction = Instruction(distance: step['distance'], duration: step['duration'], type: type, instruction: step['instruction'], name: step['name'], icon:icon );
          instructions.add(instruction);
        });
      });


      OpenRouteServiceEntities openRouteServiceEntities = OpenRouteServiceEntities(polylines: polylines, steepness: steepnessObj, surfaces: surfacesObj, instructions: instructions);
      return openRouteServiceEntities;
    } else {
      return Future.error("Something went wrong");
    }
  }

  @override
  Future<List<Feature>> getMarkersData() async {

    String jsonString = await rootBundle.loadString(accessibilityJsonFileURL);
    Map<String, dynamic> jsonData = json.decode(jsonString);
    List<dynamic> accessibilityData  = jsonData['features'];

    List<Feature> markers = accessibilityData.map((element) {
      return Feature.fromJson(element);
    }).toList();
    return markers;
  }

}
