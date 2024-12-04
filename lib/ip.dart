class ApiBase {
  static String amir = "http://192.168.0.246/e-bike";
  static String king = "http://192.168.1.109/e-bike";
  static String iman = "http://192.168.1.119/e-bike";

  static Uri get baseUri => Uri.parse(amir);

  static String get baseUrl => amir;
}