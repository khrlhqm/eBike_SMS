import 'package:ebikesms/modules/global_import.dart';

class BiometricAuthScreen extends StatefulWidget {
  const BiometricAuthScreen({super.key});

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
        await checkBiometrics();
      }

      if (authenticated) {
        // Return 1 for success
        Navigator.pop(context, 1);
      } else {
        // Return 0 for failure
        Navigator.pop(context, 0);
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      // Return 0 for error
      Navigator.pop(context, 0);
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
      body: Stack(
        children: [
          // Wave at the top
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/modules/Assets/Vector_3.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: const Stack(
              children: [
                // Back button positioned above the image
                Positioned(
                  top: 150,
                  left: 20,
                  child: BackButtonWidget(
                    buttonColor: Colors.blue,
                    iconSize: 30.0,
                  ),
                ),
              ],
            ),
          ),
          // Main content
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Verify that it's you",
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Text(
                    "Just one more step",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 100),
                  const Icon(
                    Icons.fingerprint,
                    size: 100,
                    color: Color(0xFF003366),
                  ),
                  const SizedBox(height: 100),
                  Center(
                    child: SizedBox(
                      width: 350.0,
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: _authenticate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF003366),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                          ),
                          child: const Text(
                            "Get Started",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
