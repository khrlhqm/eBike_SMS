import 'package:latlong2/latlong.dart';

class ApiBase {
  static String amir = "http://192.168.0.246/e-bike";
  static String king = "http://192.168.1.109/e-bike";
  static String iman = "http://192.168.0.30/e-bike";

  // Alternatively, if you just need the base URL as a string
  static String get baseUrl => iman;

  // Map API key to access generate the route engine 2.3082, 102.3193
  final String _apiKey =
      "5b3ce3597851110001cf6248f737414da68d42b5ac2385e410f94696";

  /// Builds the URL dynamically for the given routing profile and coordinates
  String getRouteUrl(String profile, LatLng start, LatLng end) {
    return "https://api.openrouteservice.org/v2/directions/$profile?api_key=$_apiKey&start=${start.longitude},${start.latitude}&end=${end.longitude},${end.latitude}";
  }
}

class MappingAPIBase {
  static final String _apiKey =
      "5b3ce3597851110001cf6248f737414da68d42b5ac2385e410f94696".trim();

  static String buildRouteUrl(String profile, LatLng start, LatLng end) {
    String startParam = "${start.longitude},${start.latitude}";
    String endParam = "${end.longitude},${end.latitude}";

    return Uri.parse("https://api.openrouteservice.org/v2/directions/$profile")
        .replace(queryParameters: {
      "api_key": _apiKey,
      "start": startParam,
      "end": endParam,
    }).toString();
  }
}


//"https://api.openrouteservice.org/v2/directions/cycling-regular?
//api_key=5b3ce3597851110001cf6248f737414da68d42b5ac2385e410f94696&
//start=102.3193,2.3082&end=102.3182,2.3142";

