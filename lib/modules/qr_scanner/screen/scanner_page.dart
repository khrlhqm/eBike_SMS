import 'package:flutter/material.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  QRCodeDartScanController? _controller;
  CameraController? _cameraController; // Camera controller for flashlight
  bool _isFlashlightOn = false; // Track the flashlight state
  String eBikeId = ''; // This will hold the scanned result

  @override
  void initState() {
    super.initState();
    _controller = QRCodeDartScanController();
    _initializeCamera();  // Initialize the camera for flashlight control
  }

  // Initialize camera for flashlight control
  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await _cameraController!.initialize();
  }

  // Toggle flashlight on/off
  void _toggleFlashlight() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      if (_isFlashlightOn) {
        await _cameraController!.setFlashMode(FlashMode.off); // Turn off flashlight
      } else {
        await _cameraController!.setFlashMode(FlashMode.torch); // Turn on flashlight
      }
      setState(() {
        _isFlashlightOn = !_isFlashlightOn;  // Update flashlight state
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose(); // Dispose of the camera controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan E-Bike QR Code'),
      ),
      body: Stack(
        children: [
          // QR Code Scanner View
          QRCodeDartScanView(
            controller: _controller, // Attach the controller here
            onCapture: (result) {
              setState(() {
                eBikeId = result.text ?? ''; // Update the eBike ID with the scanned result
              });

              // Check if the result matches the expected bike ID format
              if (_isValidBikeId(eBikeId)) {
                _saveBikeId(eBikeId);  // Save the bike ID to local storage
                _redirectToNextModule(context); // Redirect to another screen after scanning
              } else {
                // Show error if the bike ID is invalid
                _showErrorDialog(context);
              }
            },
            resolutionPreset: QRCodeDartScanResolutionPreset.high,
          ),
          
          // Text above the frame with no background color and closer to the frame
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25, // Closer to the frame
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'QR Code is on the bike handle',
                style: TextStyle(
                  fontSize: 18,  // Slightly smaller text size
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),

          // Frame layer for the QR code scanning area
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: MediaQuery.of(context).size.width * 0.15,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          // Close Button (for example, on top-left)
          Positioned(
            top: 30,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          
          // Flashlight (Torch) button at the bottom
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width * 0.45,
            child: IconButton(
              icon: Icon(
                _isFlashlightOn ? Icons.flashlight_off : Icons.flashlight_on,  // Torch/flashlight icon
                color: Colors.white,
                size: 40,
              ),
              onPressed: _toggleFlashlight,
            ),
          ),
        ],
      ),
    );
  }

  // Method to check if the scanned QR code matches the bike ID pattern
  bool _isValidBikeId(String id) {
    // Regex to match a bike ID that starts with 'B125' followed by 2 random digits
    final regex = RegExp(r'^B125\d{2}$');
    return regex.hasMatch(id);
  }

  // Method to show an error dialog if the bike ID is invalid
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Invalid QR code. Please scan a valid bike ID.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Method to save the scanned bike ID in shared preferences
  Future<void> _saveBikeId(String bikeId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bikeId', bikeId);
  }

  // Method to navigate to the next screen after scanning the QR code
  void _redirectToNextModule(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextModuleScreen(bikeId: eBikeId), // Pass the bike ID to the next screen
      ),
    );
  }
}

class NextModuleScreen extends StatelessWidget {
  final String bikeId;
  NextModuleScreen({required this.bikeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Bike Details'),
      ),
      body: Center(
        child: Text('E-Bike ID: $bikeId'),
      ),
    );
  }
}
