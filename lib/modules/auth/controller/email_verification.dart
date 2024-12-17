import 'dart:convert';
import 'package:ebikesms/ip.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // For API calls
import 'dart:math';

class EmailVerification {
  // Validates the email format
  bool CheckPattern(String email) {
    final emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'; // Basic pattern
    return RegExp(emailPattern).hasMatch(email);
  }

  // Sends the verification email
  Future<int> checkEmailPattern(String email, BuildContext context) async {
    if (!CheckPattern(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email format!'),
        ),
      );
      return 0; // Invalid email format
    } else {
      return 1;
    }
  }

   String generateOtp() {
    final random = Random();
    final otp = List.generate(6, (index) => random.nextInt(10)).join();
    return otp;
  }

 Future<int> sendOtpToBackend(String email, String OTP) async {
  final response = await http.post(
    Uri.parse('${ApiBase.baseUrl}/sent_otp.php'),
    body: {
      'email': email,
      'otp': OTP,
    },
  );

  if (response.statusCode == 200) {
    // Handle success
    print("OTP sent successfully.");
    return 1;
  } else {
    // Handle error
    print("Failed to send OTP.");
    return 0;
  }
}

}
