import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ebikesms/modules/auth/controller/email_verification.dart';
import 'package:ebikesms/modules/auth/screen/signup.dart';

class VerificationPage extends StatefulWidget {
  final String userEmail;
  final PageController pageController;
  // VerificationPage({required this.userEmail});
  VerificationPage(
      {required this.userEmail,
      required this.pageController}); // Receive the controller

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  String storedOtp = "";
  final String _apiKey =
      "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";

  @override
  void initState() {
    super.initState();
    storedOtp = generateOtp(); // Generate OTP
    print("sent to email:" + widget.userEmail);
    print("OTP:" + storedOtp);
    
  }

  String generateOtp() {
    final random = Random();
    final otp = List.generate(6, (index) => random.nextInt(10)).join();
    return otp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Enter the OTP sent to your email:",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(
                labelText: "OTP",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String enteredOtp = _otpController.text
                    .trim(); // Get OTP and remove extra spaces

                if (enteredOtp == storedOtp) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Email verified successfully!")),
                  );

                  // Now navigate to SignupScreen and pass the pageController
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupScreen(
                        pageController: widget
                            .pageController, // Pass the PageController back
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Invalid OTP. Please try again.")),
                  );
                }
              },
              child: const Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Next Page"),
      ),
      body: const Center(
        child: Text("Welcome to the next page!"),
      ),
    );
  }
}
