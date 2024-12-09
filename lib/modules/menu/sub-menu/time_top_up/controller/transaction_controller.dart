import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:ebikesms/ip.dart';

class TransactionController extends ChangeNotifier{
  static Future<Map<String, dynamic>> addTransaction({
    required String transactionDate,
    required int transactionTotal,
    required int obtainedRideTime,
    required int userId,
  }) async {

    // Define URL with URI
    final url = Uri.parse("${ApiBase.baseUrl}/time_top_up.php");

    try {
      debugPrint("Starting HTTP POST request to URL: $url");

      // (Try) make a json file and post to url
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "transaction_date": transactionDate,
          "transaction_total": transactionTotal,
          "obtained_ride_time": obtainedRideTime,
          "user_id": userId,
        }),
      );
      debugPrint("HTTP POST request completed. Status code: ${response.statusCode}");

      // Check if server is not responding after post
      if (response.statusCode != 200) {
        debugPrint("Server is not responding. Received status code: ${response.statusCode}");
        return {
          'status': 0,
          'message': 'Server encountered an error. Please try again later.'
        };
      }

      // (Try) decode the response body
      try {
        // Check indication if server reply was an error
        final responseBody = json.decode(response.body);
        debugPrint("Response body received: $responseBody");

        // (Try) to check if response contained success
        if (responseBody['status'] == 'error') {
          debugPrint("Payment failed. Response status: ${responseBody['status']}");
          return {
            'status': 0,
            'message': "Payment failed. Please try again later."
          };
        }
      } catch (e) { // Catch if parsing/decoding response fails
        debugPrint("Error parsing response body: $e");
        return {
          'status': 0,
          'message': "Invalid server response. Please try again later."
        };
      }
    } catch (e) { // Catch if unexpected error occurs during HTTP Post
      debugPrint("Unexpected error occurred during HTTP POST request: $e");
      return {
        'status': 0,
        'message': "Error: $e"
      };
    }

    // Successful, when all negative tests passed
    debugPrint("All checks passed. Transaction successful.");
    return {
      'status': 1,
      'message': "Successful"
    };
  }
}