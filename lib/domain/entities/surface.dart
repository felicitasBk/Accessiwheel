import '../../common/utils/log.dart';

class Surface {
  String image;
  double percentage;
  String name;

  Surface({
    required this.image,
    required this.percentage,
    required this.name,
  });

  factory Surface.fromJson(Map<String, dynamic> json) {
    try {
      return Surface(
        image: json["image"],
        percentage: json["percentage"]?.toDouble(),
        name: json["name"],
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  String get getImage {
    return image;
  } 

  String get getName {
    return name;
  }   

  double get getPercentage {
    return percentage;
  }  
}
