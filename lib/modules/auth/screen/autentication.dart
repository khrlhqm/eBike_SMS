import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthScreen extends StatefulWidget {
  @override
  _BiometricAuthScreenState createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate() async {
    try {
      // Check if biometrics are available
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool authenticated = false;

      if (canCheckBiometrics) {
        // Try to authenticate
        authenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to proceed',
          options: const AuthenticationOptions(
            biometricOnly: true, // Limit to biometric methods only
            stickyAuth: true,    // Keeps authentication active until user authenticates
          ),
        );
      }

      if (authenticated) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('assets/wave_top.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            "Face Verification",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Create your own account",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 40),
          Icon(
            Icons.face_rounded,
            size: 100,
            color: Colors.blue,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _authenticate,
            child: const Text("Get Started"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: const Text("Remind me later"),
          ),
        ],
      ),
    );
  }
}
