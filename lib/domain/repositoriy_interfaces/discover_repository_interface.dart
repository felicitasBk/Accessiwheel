import 'package:wheelmap/domain/entities/coordinate.dart';
import 'package:wheelmap/domain/entities/routes.dart';

abstract class DiscoverRepositoryInterface {
  List<Coordinate> getPlaceCoordinates();
  Future<List<Route>> getRoutesData();
}
