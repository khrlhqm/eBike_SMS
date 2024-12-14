class ApiBase {
  static String amir = "http://192.168.0.26/e-bike";
  static String king = "http://192.168.1.109/e-bike";
  static String iman = "http://192.168.0.30/e-bike";

  // Alternatively, if you just need the base URL as a string
  static String get baseUrl => iman;
}

class MapApi {
  String generateOSRMUrl(
      double startLat, double startLng, double endLat, double endLng,
      {int zoom = 15}) {
    final double centerLat = (startLat + endLat) / 2;
    final double centerLng = (startLng + endLng) / 2;

    return 'https://map.project-osrm.org/?z=$zoom'
        '&center=$centerLat,$centerLng'
        '&hl=en'
        '&alt=0'
        '&srv=1'
        '&src=$startLat,$startLng'
        '&dst=$endLat,$endLng';
  }

  // void main() {
  //   final double startLat = 2.315541;
  //   final double startLng = 102.328291;
  //   final double endLat = 2.320000;
  //   final double endLng = 102.330000;

  //   final String osrmUrl = generateOSRMUrl(startLat, startLng, endLat, endLng);
  //   print(osrmUrl);
  // }
}
