import 'package:ebikesms/modules/global_import.dart';
import 'package:ebikesms/modules/location/widget/marker.dart';
import 'package:latlong2/latlong.dart';

Widget content(MapController mapController, BuildContext context) {
  return FlutterMap(
    mapController: mapController,
    options: const MapOptions(
      initialCenter: LatLng(2.3138, 102.3211),
      initialZoom: 16.0,
      interactionOptions: InteractionOptions(flags: InteractiveFlag.all),
    ),
    children: [
      openStreetMap,
      MarkerLayer(markers: buildMarkers(context)),
      // PolylineLayer(
      //   polylines: [
      //     Polyline(
      //       // points: polylinePoints, // Use the defined points
      //       strokeWidth: 4.0, // Line width
      //       color: Colors.blue, // Line color
      //     ),
      //   ],
      // ),
    ],
  );
}

TileLayer get openStreetMap => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
