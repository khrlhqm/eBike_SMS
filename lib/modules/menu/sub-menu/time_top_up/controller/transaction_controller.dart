import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:ebikesms/ip.dart';

class TransactionController extends ChangeNotifier {
  static Future<Map<String, dynamic>> addTransaction({
    required String transactionDate,
    required int transactionTotal,
    required int obtainedRideTime,
    required int userId,
  }) async {
    final url = Uri.parse("${ApiBase.baseUrl}/time_top_up.php");

    try {
      debugPrint("Starting HTTP POST request to URL: $url");

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
      debugPrint(
          "HTTP POST request completed. Status code: ${response.statusCode}");

      if (response.statusCode != 200) {
        return {
          'status': 0,
          'message': 'Server error. Please try again later.'
        };
      }

      final responseBody = json.decode(response.body);
      debugPrint("Response body received: $responseBody");

      if (responseBody['status'] == 'error') {
        return {
          'status': 0,
          'message': responseBody['message'] ?? "Transaction failed."
        };
      }

      // Return success with the updated ride time
      return {
        'status': 1,
        'message': responseBody['message'],
        'formatted_time': responseBody['formatted_time'] // <-- Added this
      };
    } catch (e) {
      debugPrint("Error occurred during HTTP request: $e");
      return {'status': 0, 'message': "Error: $e"};
    }
  }
}
