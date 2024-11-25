import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ebikesms/modules/location/widget/marker.dart';
import 'package:ebikesms/modules/dashboard/screen/dashboard.dart';

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
        builder: (context) => const Dashboard(),
      ),
    );
  }

  Widget content() {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: LatLng(2.3138, 102.3211),
        initialZoom: 16.0,
        interactionOptions: InteractionOptions(flags: InteractiveFlag.all),
      ),
      children: [
        openStreetMap,
        MarkerLayer(markers: buildMarkers(context)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          content(),
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.lightbulb, color: Colors.yellow),
                    onPressed: _navigateToProfile,
                    splashRadius: 25,
                  ),
                ),
                const SizedBox(height: 10), // Space between buttons

                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.gps_fixed, color: Colors.blue),
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

TileLayer get openStreetMap => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
