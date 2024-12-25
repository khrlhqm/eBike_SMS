import 'package:latlong2/latlong.dart';

import '../../global_import.dart';
import '../../learn/screen/learn.dart';

class MapSideButtons extends StatefulWidget {
  final MapController mapController;
  final LatLng locationToPinpoint;
  final bool showGuideButton;

  const MapSideButtons({
    super.key,
    required this.mapController,
    required this.locationToPinpoint,
    required this.showGuideButton,
  });

  @override
  State<MapSideButtons> createState() => _MapSideButtonsState();
}

class _MapSideButtonsState extends State<MapSideButtons> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Align Map Rotation Button
          ElevatedButton(
            onPressed: () {
              animateRotation(0.0);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              backgroundColor: ColorConstant.white, // Background color
              shadowColor: ColorConstant.lightGrey, // Box shadow color
              elevation: 2,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CustomIcon.compassColoured(30),
            ),
          ),
          const SizedBox(height: 13),

          // Pinpoint User Button
          ElevatedButton(
              onPressed: () {
                animatePinpoint(widget.locationToPinpoint);
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: EdgeInsets.zero,
                backgroundColor: ColorConstant.white, // Background color
                shadowColor: ColorConstant.lightGrey, // Box shadow color
                elevation: 2,
              ),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: CustomIcon.crosshairColoured(25),
              )
          ),
          const SizedBox(height: 13),

          // Visit Guide Button
          Visibility(
            visible: widget.showGuideButton,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LearnScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.zero,
                backgroundColor: ColorConstant.white,
                shadowColor: ColorConstant.lightGrey,
                elevation: 2,
                minimumSize: const Size(52, 53), // Directly set size here
              ),
              child: CustomIcon.learnColoured(30),
            ),
          )
        ],
      ),
    );
  }

  void animateRotation(double targetRotation) {
    const duration = Duration(milliseconds: 300); // Duration for animation (adjust as needed)

    // Create an AnimationController with the current vsync (usually this in StatefulWidget)
    final controller = AnimationController(vsync: this, duration: duration);

    // Define a CurvedAnimation for smooth easing
    final curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    // Get the current rotation of the map
    final currentRotation = widget.mapController.camera.rotation;

    // Define a Tween to animate the rotation from current rotation to target rotation
    final rotationTween = Tween<double>(begin: currentRotation, end: targetRotation);

    // Add a listener to update the map's rotation as the animation progresses
    controller.addListener(() {
      final rotation = rotationTween.evaluate(curve);
      widget.mapController.rotate(rotation);  // Update the map's rotation
    });

    // Start the animation and dispose of the controller once done
    controller.forward().whenComplete(() {
      controller.dispose();
    });
  }

  void animatePinpoint(LatLng target) {
    // Set the duration of the animation
    const duration = Duration(milliseconds: 500); // 1 second for a smoother transition

    // Create an AnimationController
    final controller = AnimationController(vsync: this, duration: duration);

    // Add a CurvedAnimation to apply a smooth curve to the animation
    final curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    // Define the Tween for each property (latitude, longitude, and zoom)
    final latTween = Tween<double>(begin: widget.mapController.camera.center.latitude, end: target.latitude);
    final lngTween = Tween<double>(begin: widget.mapController.camera.center.longitude, end: target.longitude);
    final zoomTween = Tween<double>(begin: widget.mapController.camera.zoom, end: MapConstant.zoomLevel); // Adjust zoom if needed

    // Listen for the animation progress
    controller.addListener(() {
      final lat = latTween.evaluate(curve);
      final lng = lngTween.evaluate(curve);
      final zoomLevel = zoomTween.evaluate(curve);

      // Move the map to the animated position and zoom level
      widget.mapController.move(LatLng(lat, lng), zoomLevel);
    });

    // Start the animation and dispose of the controller once it's done
    controller.forward().whenComplete(() {
      controller.dispose();
    });
  }
}

