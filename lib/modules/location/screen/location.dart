import 'package:ebikesms/modules/learn/screen/learn.dart';
import 'package:ebikesms/modules/global_import.dart';
import 'package:latlong2/latlong.dart';
// import 'package:ebikesms/modules/location/widget/content.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final MapController _mapController = MapController();

  void _getCurrentLocation() {
    setState(() {
      _mapController.move(const LatLng(2.3138, 102.3211), 16.0);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Moved to current location")),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LearnScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // content(_mapController, context),
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: ColorConstant.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstant.black,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.lightbulb,
                        color: ColorConstant.yellow),
                    onPressed: _navigateToProfile,
                    splashRadius: 25,
                  ),
                ),
                const SizedBox(height: 10), // Space between buttons

                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: ColorConstant.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstant.black,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.gps_fixed,
                        color: ColorConstant.darkBlue),
                    onPressed: _getCurrentLocation,
                    splashRadius: 25,
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
