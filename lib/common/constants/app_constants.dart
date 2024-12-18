import 'package:flutter_dotenv/flutter_dotenv.dart';

enum TabName { discover, favourites, plan }

String mapTilerAPIKey = dotenv.env["MAP_TILER_API_KEY"] as String;
String openRouteServiceAPIKey =
    dotenv.env["OPEN_ROUTE_SERVICE_API_KEY"] as String;
String accessiblityCloudAPIKey = dotenv.env["ACCESSIBILITY_CLOUD_API_KEY"] as String;

String tileLayerURL =
    'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=$mapTilerAPIKey';
String openRouteServiceURL =
    'https://api.openrouteservice.org/v2/directions/wheelchair/geojson?api_key=$openRouteServiceAPIKey';
String accessibilitlyURL =
    'https://accessibility-cloud.freetls.fastly.net/place-infos?latitude=49.891389&longitude=10.886944&accuracy=10000\&appToken=$accessiblityCloudAPIKey';
String routesJsonFileURL =
    'assets/json/routes.json';
String accessibilityJsonFileURL =
    'assets/json/accessibility_data.json';
