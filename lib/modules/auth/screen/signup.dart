import 'package:ebikesms/modules/global_import.dart';
import 'package:ebikesms/modules/auth/controller/signup_controller.dart';
import 'package:ebikesms/modules/auth/controller/email_verification.dart';
import 'package:ebikesms/modules/auth/screen/verification.dart';

class SignupScreen extends StatefulWidget {
  // const SignupScreen({super.key});
    final PageController pageController;
    const SignupScreen({super.key, required this.pageController});


  
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignupScreen> {
  late PageController _pageController;
  final TextEditingController _matricnumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _repassword = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _OTP = TextEditingController();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _username = TextEditingController();

  bool _isPasswordVisible = false; // Track the password visibility
  bool _isPasswordMatch = true; // Track whether the passwords match
  bool _isEmailValid = true;

@override
  void initState() {
    super.initState();
    _pageController = widget.pageController;  // Use the passed PageController
    
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the controller when no longer needed
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _handleSignup() async {
    int result = await SignupController().registerUser(
      context,
      _matricnumber.text,
      _password.text,
      _repassword.text,
      _fullname.text,
      _username.text,
    );

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

  void _validatePasswords() {
    setState(() {
      _isPasswordMatch = _password.text == _repassword.text;
    });
  }

// Inside your SignupScreen
void verifyEmail() async {
  String email = _email.text; // Get email from the TextEditingController
  final emailVerification = EmailVerification();
  int result = await emailVerification.sendVerificationEmail(email, context);


  if (result == 1) {
    _isEmailValid = true;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationPage(
          userEmail: email,
          pageController: _pageController,  // Pass PageController here
        ),
      ),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 245, 252),
      body: PageView(
        controller:   widget.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Page 1: Matric Number and Password
          SingleChildScrollView(
            child: Column(
              children: [
                // Header section with wave and icon
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
                  child: Stack(
                    children: [
                      // The image is still the background
                      Positioned.fill(
                        child: Container(
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
                      ),
                      // Back button positioned above the image
                      const Positioned(
                        top:
                            150, // Adjust the top position to move the button up/down
                        left:
                            20, // Adjust the left position for horizontal alignment
                        child: BackButtonWidget(
                          buttonColor: Colors.blue, // Optional custom color
                          iconSize: 30.0, // Optional custom icon size
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Let's Get Started",
                          style: TextStyle(
                            fontSize: 30,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Center(
                        child: Text(
                          "Create your own account",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Matric Number TextField
                      Center(
                        child: SizedBox(
                          width: 350.0,
                          child: TextField(
                            controller: _matricnumber,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Matric Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Color(0xFF003366),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Password TextField
                      Center(
                        child: SizedBox(
                          width: 350.0,
                          child: TextField(
                            obscureText:
                                !_isPasswordVisible, // Use the boolean to toggle visibility
                            controller: _password,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Color(0xFF003366),
                                  width: 2.0,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Confirm Password TextField
                      Center(
                        child: SizedBox(
                          width: 350.0,
                          child: TextField(
                            obscureText:
                                !_isPasswordVisible, // Make the confirm password also toggle
                            controller: _repassword,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Confirm Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Color(0xFF003366),
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onChanged: (_) =>
                                _validatePasswords(), // Validate passwords on change
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Next Button
                      // Next Button
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: _isPasswordMatch && _username.text.isEmpty
                              ? _nextPage
                              : null,
                          // Disable button if passwords don't match or username is empty
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF003366),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

// Error message if passwords don't match
                      if (!_isPasswordMatch)
                        const Text(
                          "Passwords do not match!",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),

// Error message if username is empty
                      if (_username.text.isEmpty)
                        const Text(
                          "Fill all the details",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Page 2: email

          SingleChildScrollView(
            child: Column(
              children: [
                // Header section with wave and icon
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
                  child: Stack(
                    children: [
                      // The image is still the background
                      Positioned.fill(
                        child: Container(
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
                      ),
                      // Back button positioned above the image
                      const Positioned(
                        top:
                            150, // Adjust the top position to move the button up/down
                        left:
                            20, // Adjust the left position for horizontal alignment
                        child: BackButtonWidget(
                          buttonColor: Colors.blue, // Optional custom color
                          iconSize: 30.0, // Optional custom icon size
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Almost There!",
                          style: TextStyle(
                            fontSize: 30,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Center(
                        child: Text(
                          "Just a few more details",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Full Name TextField
                      Center(
                        child: SizedBox(
                          width: 350.0,
                          child: TextField(
                            controller: _email,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Color(0xFF003366),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                      ),
                      const SizedBox(height: 15),
                      // Username TextField
                     
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed:
                              verifyEmail, // Pass the function reference here
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF003366),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold,
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

          // Page 3: Full Name and Username
          SingleChildScrollView(
            child: Column(
              children: [
                // Header section with wave and icon
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
                  child: Stack(
                    children: [
                      // The image is still the background
                      Positioned.fill(
                        child: Container(
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
                      ),
                      // Back button positioned above the image
                      const Positioned(
                        top:
                            150, // Adjust the top position to move the button up/down
                        left:
                            20, // Adjust the left position for horizontal alignment
                        child: BackButtonWidget(
                          buttonColor: Colors.blue, // Optional custom color
                          iconSize: 30.0, // Optional custom icon size
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Almost There!",
                          style: TextStyle(
                            fontSize: 30,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Center(
                        child: Text(
                          "Just a few more details",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Full Name TextField
                      Center(
                        child: SizedBox(
                          width: 350.0,
                          child: TextField(
                            controller: _fullname,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Full Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Color(0xFF003366),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Username TextField
                      Center(
                        child: SizedBox(
                          width: 350.0,
                          child: TextField(
                            controller: _username,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Color(0xFF003366),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: _handleSignup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF003366),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}
