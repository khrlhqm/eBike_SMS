import 'package:ebikesms/modules/global_import.dart';

String generateOSRMMultiLocationUrl({
  required List<Map<String, double>>
      locations, // List of { "lat": x, "lng": y }
  int zoom = 17, // Default zoom level
  String language = 'en', // Default language
}) {
  if (locations.isEmpty) {
    throw ArgumentError("Locations cannot be empty");
  }

  // Calculate the map center (average of all coordinates)
  final double centerLat =
      locations.map((loc) => loc["lat"]!).reduce((a, b) => a + b) /
          locations.length;
  final double centerLng =
      locations.map((loc) => loc["lng"]!).reduce((a, b) => a + b) /
          locations.length;

  // Generate the loc parameters
  final String locParams = locations
      .map((loc) =>
          "loc=${loc["lat"]!.toStringAsFixed(6)}%2C${loc["lng"]!.toStringAsFixed(6)}")
      .join('&');

  // Build the URL
  return 'https://map.project-osrm.org/?z=$zoom'
      '&center=$centerLat%2C$centerLng'
      '&$locParams'
      '&hl=$language'
      '&alt=0'
      '&srv=1';
}
