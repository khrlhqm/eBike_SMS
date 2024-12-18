import 'package:ebikesms/modules/global_import.dart';
import 'package:flutter/material.dart';
import 'package:ebikesms/shared/utils/custom_icon.dart'; // Import CustomIcon
import 'package:http/http.dart' as http; // For API calls
import 'package:ebikesms/ip.dart';
import 'package:ebikesms/modules/auth/screen/login.dart';

class SetNewPasswordScreen extends StatefulWidget {
  final String email;
  const SetNewPasswordScreen({super.key, required this.email});

  @override
  SetNewPasswordScreenState createState() => SetNewPasswordScreenState();
}

class SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  bool _passwordVisible = false; // To toggle password visibility
  final TextEditingController _passwordController = TextEditingController();

  bool _repasswordVisible = false; // To toggle re-password visibility
  final TextEditingController _repasswordController = TextEditingController();

  bool isButtonEnabled = false; // Button enabled state

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkPasswordMatch);
    _repasswordController.addListener(_checkPasswordMatch);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _repasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordMatch() {
    final password = _passwordController.text;
    final rePassword = _repasswordController.text;

    setState(() {
      isButtonEnabled = password.isNotEmpty &&
          rePassword.isNotEmpty &&
          password == rePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorConstant.hintBlue, // Light blue background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorConstant.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.03),
                // Custom Lock Icon
                CustomIcon.newpass(screenWidth * 0.28), // CustomIcon usage

                SizedBox(height: screenHeight * 0.03),
                // Forget Password Title
                const Text(
                  "New\nCredential",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: ColorConstant.black,
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),
                // Subtitle
                const Text(
                  "Your identity has been verified\nset your new password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: ColorConstant.grey,
                  ),
                ),

                SizedBox(height: screenHeight * 0.045),
                // Password TextField
                SizedBox(
                  width: screenWidth * 0.85,
                  child: TextField(
                    obscureText: !_passwordVisible,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white, // White background
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Color(0xFF003366), // Blue border color
                          width: 2.0,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Re-Password TextField
                SizedBox(
                  width: screenWidth * 0.85,
                  child: TextField(
                    obscureText: !_repasswordVisible,
                    controller: _repasswordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Re-Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Color(0xFF003366),
                          width: 2.0,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _repasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _repasswordVisible = !_repasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                // Update Button
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.065,
                    child: ElevatedButton(
                      onPressed: isButtonEnabled
                          ? () async {
                              final email = widget.email;
                              final newPassword = _passwordController.text;

                              print("Email sent: $email"); // Debug log
                              print(
                                  "New Password sent: $newPassword"); // Debug log

                              // Replace with your API endpoint
                              final response = await http.post(
                                Uri.parse(
                                    '${ApiBase.baseUrl}/reset_password.php'), // Corrected filename
                                headers: {'Content-Type': 'application/json'},
                                body: jsonEncode({
                                  "email": email,
                                  "new_password": newPassword,
                                }),
                              );

                              print(
                                  "API Response Status Code: ${response.statusCode}"); // Debug log
                              print(
                                  "API Response Body: ${response.body}"); // Debug log

                              if (response.statusCode == 200) {
                                // Parse the JSON response
                                final responseData = jsonDecode(response.body);

                                if (responseData['status'] == 'success') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Password updated successfully."),
                                    ),
                                  );

                                  // Navigate to ForgetPasswordScreen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LoginScreen(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(responseData['message']),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Something went wrong. Please try again."),
                                  ),
                                );
                              }
                            }
                          : null,

                      // Disable button when not enabled
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003366),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey,
                        disabledForegroundColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
