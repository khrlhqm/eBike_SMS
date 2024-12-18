import 'package:latlong2/latlong.dart';

import '../../global_import.dart';

class CustomMap extends StatelessWidget{
  final MapController mapController;
  final List<Marker> allMarkers;
  final LatLng initialCenter;
  final bool enableInteraction;

  const CustomMap({super.key, 
    required this.mapController,
    required this.allMarkers,
    required this.initialCenter,
    required this.enableInteraction
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: 16.0,
        interactionOptions: InteractionOptions(
          flags: (enableInteraction) ? InteractiveFlag.all : InteractiveFlag.none
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(markers: allMarkers),
        PolygonLayer(
          polygons: [
            Polygon(
              points: MapConstant.theWholeWorld,
              holePointsList: [MapConstant.geoFencePoints],
              color: ColorConstant.hintBlue.withOpacity(0.6), // Fill color with opacity
              borderColor: Colors.blue,           // Border color
              borderStrokeWidth: 1.0,
            )
          ],
        )
      ],
    );
  }
}