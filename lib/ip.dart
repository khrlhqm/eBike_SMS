import 'package:latlong2/latlong.dart';

class ApiBase {
  static String amir = "http://192.168.0.26/e-bike";
  static String king = "http://192.168.1.109/e-bike";
  static String iman = "http://192.168.0.30/e-bike";
  static String ApiRoute =
      'https://map.project-osrm.org/?z=15&center=2.3177705,102.3291455&hl=en&alt=0&srv=1&src=2.315541,102.328291&dst=2.32,102.33';

  // Alternatively, if you just need the base URL as a string
  static String get baseUrl => iman;
}

class MapApi {
  String generateOSRMMultiLocationUrl({
    required List<LatLng> locations,
  }) {
    const String baseUrl = 'https://map.project-osrm.org/?z=17';
    final List<String> locParams =
        locations.map((loc) => 'loc=${loc.latitude},${loc.longitude}').toList();

    final String centerLat =
        (locations.map((e) => e.latitude).reduce((a, b) => a + b) /
            locations.length) as String;
    final String centerLng =
        (locations.map((e) => e.longitude).reduce((a, b) => a + b) /
            locations.length) as String;

    return '$baseUrl&center=$centerLat,$centerLng&${locParams.join('&')}&hl=en&alt=0&srv=1';
  }
}
