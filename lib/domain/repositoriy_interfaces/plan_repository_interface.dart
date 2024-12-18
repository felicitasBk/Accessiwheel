import 'package:wheelmap/domain/entities/feature.dart';
import 'package:wheelmap/domain/entities/ors_entities.dart';

abstract class PlanRepositoryInterface {
  Future<OpenRouteServiceEntities> getRouteData(List<List<double>> coordinates);
  Future<List<Feature>> getMarkersData();
}
