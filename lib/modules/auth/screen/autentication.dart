import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ebikesms/modules/auth/screen/login.dart';

class BiometricAuthScreen extends StatefulWidget {
  @override
  _BiometricAuthScreenState createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      print('Can check biometrics: $canCheckBiometrics');
      bool authenticated = false;

      if (canCheckBiometrics) {
        authenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to proceed',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
        print('Authentication result: $authenticated');
      } else {
        print('Biometrics not available');
        checkBiometrics();
      }

      if (authenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication success')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication failed')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> checkBiometrics() async {
  try {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    print('Can check biometrics: $canCheckBiometrics');
    print('Available biometrics: $availableBiometrics');
  } catch (e) {
    print('Error checking biometrics: $e');
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
              image: DecorationImage(
                image: AssetImage('lib/modules/Assets/Vector_3.png'),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: const Text("Remind me later"),
          ),
        ],
      ),
    );
  }
}
