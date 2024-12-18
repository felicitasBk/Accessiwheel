import 'package:wheelmap/domain/entities/coordinate.dart';
import 'package:wheelmap/domain/repositoriy_interfaces/discover_repository_interface.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:wheelmap/common/constants/app_constants.dart';
import 'package:wheelmap/domain/entities/routes.dart';

class DiscoverRepository implements DiscoverRepositoryInterface {
  @override
  List<Coordinate> getPlaceCoordinates() {
    //TODO: - Please implement this later
    return [];
  }

  @override
  Future<List<Route>> getRoutesData() async {
    String jsonString = await rootBundle.loadString(routesJsonFileURL);
    Map<String, dynamic> jsonData = json.decode(jsonString);
    List<dynamic> jsonRoutes  = jsonData['routes'];
    List<Route> routes = jsonRoutes.map((json) => Route.fromJson(json)).toList();
    return routes;
  }
}
