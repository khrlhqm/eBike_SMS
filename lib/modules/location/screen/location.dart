import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  get angleInDegrees => 2.3138;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Widget content() {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(2.3138, 102.3211),
        initialZoom: 13.0,
        interactionOptions: InteractionOptions(flags: InteractiveFlag.all),
      ),
      children: [
        openStreetMap,
      ],
    );
  }
}

TileLayer get openStreetMap => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
