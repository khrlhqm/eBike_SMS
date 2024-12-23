import 'package:flutter/material.dart';
import 'package:ebikesms/modules/global_import.dart';
import 'package:ebikesms/modules/auth/screen/signup/authentication.dart';
import 'package:ebikesms/modules/auth/controller/signup_controller.dart';

class FullNameUsernameScreen extends StatefulWidget {
  final matricnumber, password, email;
  const FullNameUsernameScreen(
      {super.key,
      required this.matricnumber,
      required this.password,
      required this.email});

  @override
  State<FullNameUsernameScreen> createState() => _FullNameUsernameScreenState();
}

class _FullNameUsernameScreenState extends State<FullNameUsernameScreen> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _username = TextEditingController();

  void _handleSignup() async {
    int result = await SignupController().registerUser(context, widget.email,
        widget.matricnumber, widget.password, _fullName.text, _username.text);

    if (result == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorConstant.hintBlue,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header with Stack for Vector3 Image and Back Button
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Vector_3.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: ColorConstant.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Complete Your Profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.085,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.black,
                    ),
                  ),
                  Text(
                    "Enter your full name and username",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.normal,
                      color: ColorConstant.grey,
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: screenWidth * 0.85,
                    child: Column(
                      children: [
                        // Full Name TextField
                        TextField(
                          controller: _fullName,
                          decoration: InputDecoration(
                            labelText: "Full Name",
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
                        const SizedBox(height: 15),
                        // Username TextField
                        TextField(
                          controller: _username,
                          decoration: InputDecoration(
                            labelText: "Username",
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Next Button
                  SizedBox(
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.07,
                    child: ElevatedButton(
                      onPressed:
                          _fullName.text.isNotEmpty && _username.text.isNotEmpty
                              ? () async {
                                  // Navigate to the next screen and await the result
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BiometricAuthScreen()),
                                  );

                                  // Check if the result is 1, indicating successful authentication
                                  if (result == 1) {
                                    _handleSignup();
                                    // print("here");
                                  }
                                }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003366),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Finish',
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
