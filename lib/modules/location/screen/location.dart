import 'package:ebikesms/modules/learn/screen/learn.dart';
import 'package:ebikesms/modules/global_import.dart';
import 'package:latlong2/latlong.dart';
import 'package:ebikesms/modules/location/widget/marker.dart';

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

  void _navigateToGuide() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LearnScreen(),
      ),
    );
  }

  TileLayer get _getOpenStreetMap => TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  );

  Widget _displayMap() {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: LatLng(2.3138, 102.3211),
        initialZoom: 16.0,
        interactionOptions: InteractionOptions(flags: InteractiveFlag.all),
      ),
      children: [
        _getOpenStreetMap,
        MarkerLayer(markers: buildMarkers(context)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.centerRight,
        children: [
          _displayMap(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _getCurrentLocation,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                      backgroundColor: ColorConstant.white, // Background color
                      shadowColor: ColorConstant.black, // Box shadow color
                      elevation: 5,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: CustomIcon.crosshairColoured(30),
                    )
                ),
                const SizedBox(height: 15),
                Container(
                  width: 59,
                  height: 60,
                  decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(
                        color: ColorConstant.shadow, blurRadius: 10, offset: Offset(0, 1)
                    )],
                  ),
                  child: ElevatedButton(
                      onPressed: _navigateToGuide,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.zero,
                        backgroundColor: ColorConstant.white, // Background color
                        shadowColor: ColorConstant.black, // Box shadow color
                        elevation: 5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: CustomIcon.learnColoured(40),
                      )
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


