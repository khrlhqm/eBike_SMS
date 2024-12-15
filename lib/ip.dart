import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiBase {
  // Static URLs for local development
  static String amir = "http://192.168.0.31/e-bike";
  static String king = "http://192.168.1.109/e-bike";
  static String iman = "http://192.168.1.119/e-bike";

  // Base URL
  static String get baseUrl => dotenv.env['BASE_URL'] ?? amir;

  // SendGrid API Key
  static String get sendGridApiKey {
    final apiKey = dotenv.env['SENDGRID_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception("SendGrid API key not found in environment variables.");
    }
    return apiKey;
  }
}
