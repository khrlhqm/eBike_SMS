import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // For API calls
import 'dart:math';
import 'package:ebikesms/modules/auth/screen/verification.dart';

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

  Future<int> sentOtpToEmail(
      String email,String OTP, BuildContext context) async {
    
    try {
      final Uri url = Uri.parse("https://api.sendgrid.com/v3/mail/send");
      final String APIkey ="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";

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $APIkey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "personalizations": [
            {
              "to": [
                {"email": email}
              ],
              "subject": "Your Verification Code"
            }
          ],
          "from": {
            "email": "amirhmzh02@gmail.com"
          }, // Replace with your verified email
          "content": [
            {"type": "text/plain", "value": "Your verification code is: $OTP"}
          ]
        }),
      );

      if (response.statusCode == 202) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification email sent!'),
          ),
        );
        return 1; // Success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Failed to send verification email: ${response.body}'),
          ),
        );
        return 0; // Failure
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
    return 0;
  }
}
