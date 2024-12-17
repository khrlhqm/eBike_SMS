import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ebikesms/ip.dart';
import 'package:http/http.dart' as http;

class BikeDataController extends ChangeNotifier {
  static Future<Map<String, dynamic>> getBikes() async {
    // Define the API URL
    final url = Uri.parse("${ApiBase.baseUrl}/get_bike_data.php"); // TODO: Remember to run the host first
    debugPrint("Starting HTTP POST request to URL: $url");

    try {
      // Perform the HTTP POST request
      final response = await http.post(url);
      debugPrint("Response status code: ${response.statusCode}");

      // Check if the HTTP response indicates failure (non-200 status)
      if (response.statusCode != 200) {
        return {
          'status': 0, // Indicate failure
          'message': "HTTP response indicates failure",
        };
      }

      // Decode the response body as JSON
      final responseBody = json.decode(response.body);
      debugPrint("Decoded response body: $responseBody");

      // Handle if response status has error
      if (responseBody['status'] == 'error') {
        debugPrint("Get location failed. Response status: ${responseBody['status']}");
        return {
          'status': 0, // Indicate failure
          'message': responseBody['message'],
        };
      }

      // Handle if response status is successful
      if (responseBody['status'] == 'success') {
        debugPrint("Get location successful. Response status: ${responseBody['status']}");
        return {
          'status': 1, // Indicate success
          'message': responseBody['message'],
          'data': responseBody['data'],
        };
      }

      // Handle unexpected statuses in the response body
      debugPrint("Unexpected status in response body: ${responseBody['status']}");
      return {
        'status': 0, // Indicate failure
        'message': responseBody['message'],
      };

    } on FormatException catch (e) { // Catch decoding/parsing error of json
      debugPrint("Error decoding response body: $e");
      return {
        'status': 0, // Indicate failure
        'message': e.toString()
      };

    } catch (e) { // Catch other unexpected errors
      debugPrint("Unexpected error occurred during HTTP POST request: $e");
      return {
        'status': 0, // Indicate failure
        'message': e.toString()
      };
    }
  }


}