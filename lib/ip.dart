import 'package:latlong2/latlong.dart';

class ApiBase {
  // Static URLs for local development
  static String amir = "http://192.168.0.31/e-bike";
  static String king = "http://192.168.1.109/e-bike";
  static String iman = "http://192.168.0.30/e-bike";

  // Alternatively, if you just need the base URL as a string
  static String get baseUrl => iman;
}
