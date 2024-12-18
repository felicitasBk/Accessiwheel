import 'package:wheelmap/domain/entities/instruction.dart';
import 'package:wheelmap/domain/entities/polyline.dart';
import 'package:wheelmap/domain/entities/steepness.dart';
import 'package:wheelmap/domain/entities/surface.dart';

class OpenRouteServiceEntities {
  List<Polyline> polylines;
  List<Steepness> steepness;
  List<Surface> surfaces;
  List<Instruction> instructions;

  OpenRouteServiceEntities(
      {required this.polylines,
      required this.steepness,
      required this.surfaces,
      required this.instructions});

  factory OpenRouteServiceEntities.fromJson(Map<String, dynamic> json) => OpenRouteServiceEntities(
        surfaces: List<Surface>.from(
            json["surfaces"].map((x) => Surface.fromJson(x))),
        steepness: List<Steepness>.from(
            json["steepness"].map((x) => Steepness.fromJson(x))),
        polylines: List<Polyline>.from(
            json["polylines"].map((x) => Polyline.fromJson(x))),
        instructions: List<Instruction>.from(
            json["instructions"].map((x) => Instruction.fromJson(x))),
      );
}





