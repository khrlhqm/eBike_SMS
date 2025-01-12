import 'package:ebikesms/modules/global_import.dart';
import 'package:flutter/material.dart';
import 'package:ebikesms/shared/utils/custom_icon.dart'; // Import CustomIcon
import 'package:ebikesms/modules/auth/screen/forgetpassword/screen/email_exist_otp.dart';
import 'package:ebikesms/modules/auth/controller/email_verification.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  _ForgetpasswordState createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<ForgetPasswordScreen> {

  final TextEditingController _email = TextEditingController();
String otp = "";
  Future<int> _checkemailexist() async {
    final email = _email.text;
    final result = await EmailVerification().checkEmailExistence(email);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
      body: SingleChildScrollView(  // Wrap the body with SingleChildScrollView
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Dynamic padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                // Custom Lock Icon
                CustomIcon.forgetpassword(110), // CustomIcon usage

                const SizedBox(height: 20),
                // Forget Password Title
                Text(
                  "Forget\nPassword",
                  textAlign: TextAlign.center, // Align text to center
                  style: TextStyle(
                    fontSize: screenWidth * 0.085, // Dynamic font size based on screen width
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: ColorConstant.black,
                  ),
                ),

                const SizedBox(height: 10),
                // Subtitle
                Text(
                  "Provide your account email which you use to create your account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035, // Dynamic font size
                    fontFamily: 'Poppins',
                    color: ColorConstant.grey,
                  ),
                ),

                const SizedBox(height: 50),
                // Email Address TextField
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.85, // Dynamic width based on screen width
                    height: screenHeight * 0.07, // Dynamic height based on screen height
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: ColorConstant.grey,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            color: ColorConstant.darkBlue,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),
                // Send Instruction Button
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.85, // Dynamic width
                    height: screenHeight * 0.07, // Dynamic height
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_email.text.isNotEmpty) {
                          int result = await EmailVerification()
                              .checkEmailPattern(_email.text, context);

                          if (result == 1) {
                            int result = await _checkemailexist();
                            if (result == 1) {
                              // send otp and email here the push to next screen
                              try {
                                    otp = EmailVerification().generateOtp();
                                    result = await EmailVerification()
                                        .sendOtpToBackend(_email.text, otp);

                                   
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Error: $e'),
                                      ),
                                    );
                                  }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EmailExistScreen(otpSent: otp, email: _email.text),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('The email does not exist'),
                                ),
                              );
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003366),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Send Instruction',
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035, // Dynamic font size
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
