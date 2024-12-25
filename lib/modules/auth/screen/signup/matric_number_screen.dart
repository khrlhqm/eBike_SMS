import 'package:flutter/material.dart';
import 'package:ebikesms/modules/global_import.dart';
import 'package:ebikesms/modules/auth/screen/signup/email_screen.dart';

class MatricPasswordScreen extends StatefulWidget {
  const MatricPasswordScreen({super.key});

  @override
  State<MatricPasswordScreen> createState() => _MatricPasswordScreenState();
}

class _MatricPasswordScreenState extends State<MatricPasswordScreen> {
  final TextEditingController _matricNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _rePassword = TextEditingController();
  

  bool _isPasswordVisible = false;
  bool _isRePasswordVisible = false;
  bool _isPasswordMatch = true;

  void _validatePasswords() {
    setState(() {
      _isPasswordMatch = _password.text == _rePassword.text;
    });
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
                  top: 100, // Adjust this value as needed for padding
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: ColorConstant.black),
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
                    "Let's Get Started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.085,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.black,
                    ),
                  ),
                  Text(
                    "Create your own account",
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
                        // Matric Number TextField
                        TextField(
                          controller: _matricNumber,
                          decoration: InputDecoration(
                            labelText: "Matric Number",
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
                        // Password TextField
                        TextField(
                          controller: _password,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: ColorConstant.grey,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: ColorConstant.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
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
                        // Re-enter Password TextField
                        TextField(
                          controller: _rePassword,
                          obscureText: !_isRePasswordVisible,
                          decoration: InputDecoration(
                            labelText: "Re-enter Password",
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: ColorConstant.grey,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isRePasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: ColorConstant.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isRePasswordVisible = !_isRePasswordVisible;
                                });
                              },
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
                          onChanged: (_) => _validatePasswords(),
                        ),
                        if (!_isPasswordMatch)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Passwords do not match!",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: screenWidth * 0.035,
                                fontFamily: 'Poppins',
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
                      onPressed: _matricNumber.text.isNotEmpty &&
                              _isPasswordMatch &&
                              _password.text.isNotEmpty &&
                              _rePassword.text.isNotEmpty
                          ? () {
                              // Navigate to the next screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EmailScreen(
                                            matricnumber:_matricNumber.text ,
                                            password: _password.text,
                                          )),
                                );
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
                        'Next',
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
