import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ebikesms/modules/auth/screen/login.dart';

class SignupController extends ChangeNotifier {
  Future<void> registerUser(
      BuildContext context, String matricNumber, String password, String confirmPassword, String fullname, String username) async {
    
    // Validation: check for empty fields and matching passwords
    if (matricNumber.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // Define the URL for the API endpoint
    final url = Uri.parse("http://192.168.0.25/e-bike/signup.php");

    try {
      // Make a POST request with JSON body
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "matric_number": matricNumber,
          "password": password,
          "username" : username,
          "full_name" : fullname,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        if (responseBody['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful')),
          );

          // Navigate to login or home screen
        
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseBody['message'] ?? 'Registration failed')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Server error. Please try again later.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sni: $e')),
      );
    }
  }
}
