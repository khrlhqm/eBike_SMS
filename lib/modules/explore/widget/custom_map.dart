import 'package:latlong2/latlong.dart';

import '../../global_import.dart';

class CustomMap extends StatelessWidget{
  final  mapController;
  final ValueNotifier<List<Marker>> allMarkers;
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
    return ValueListenableBuilder(
      valueListenable: allMarkers,
      builder: (context, markers, widget) {
        if (markers.isEmpty) {
          return Center(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: ColorConstant.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: ColorConstant.shadow,
                          offset: Offset(0, 2),
                          blurRadius: 10,
                          spreadRadius: 0
                      )
                    ]
                ),
                child: const LoadingAnimation(dimension: 30),
              )
          );
        }

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
            MarkerLayer(markers: markers),
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
      },
    );
  }
}