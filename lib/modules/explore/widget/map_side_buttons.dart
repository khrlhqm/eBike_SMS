import 'package:latlong2/latlong.dart';

import '../../global_import.dart';
import '../../learn/screen/learn.dart';

class MapSideButtons extends StatefulWidget {
  final MapController mapController;
  final LatLng currentUserLocation;
  final bool showGuideButton;

  const MapSideButtons({
    super.key,
    required this.mapController,
    required this.currentUserLocation,
    required this.showGuideButton,
  });

  @override
  State<MapSideButtons> createState() => _MapSideButtonsState();
}

class _MapSideButtonsState extends State<MapSideButtons> {
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
              setState(() {
                widget.mapController.rotate(0.0);
              });
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
                setState(() {
                  widget.mapController.move(
                      LatLng(
                          widget.currentUserLocation.latitude ?? MapConstant.initCenterPoint.latitude,
                          widget.currentUserLocation.longitude ?? MapConstant.initCenterPoint.longitude
                      ), 16.0);
                });
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
                elevation: 5,
                minimumSize: const Size(54, 55), // Directly set size here
              ),
              child: CustomIcon.learnColoured(30),
            ),
          )
        ],
      ),
    );
  }
}

