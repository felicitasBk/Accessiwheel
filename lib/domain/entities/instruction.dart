import 'package:flutter/material.dart';

class Instruction {
    double distance;
    double duration;
    String type;
    String instruction;
    String name;
    IconData icon;

    Instruction({
        required this.distance,
        required this.duration,
        required this.type,
        required this.instruction,
        required this.name,
        required this.icon
    });

    factory Instruction.fromJson(Map<String, dynamic> json) => Instruction(
        distance: json["distance"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        type: json["type"],
        instruction: json["instruction"],
        name: json["name"],
        icon: json["icon"]
    );

    Map<String, dynamic> toJson() => {
        "distance": distance,
        "duration": duration,
        "type": type,
        "instruction": instruction,
        "name": name,
        "icon": icon
    };
}
