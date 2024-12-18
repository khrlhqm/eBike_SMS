import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../shared/utils/custom_icon.dart';

class CustomMarker {

  static Marker user({
    required double latitude,
    required double longitude})
  {
    return Marker(
      key: const ValueKey("user_marker"),
      width: 20,
      height: 20,
      point: LatLng(latitude, longitude),
      child: CustomIcon.userMarker(1),
    );
  }

  static Marker riding({
    required double latitude,
    required double longitude,
    VoidCallback? onTap})
  {
    return Marker(
      width: 20,
      height: 20,
      point: LatLng(latitude, longitude),
      child: CustomIcon.ridingMarker(1),
    );
  }

  static location({
    required double latitude,
    required double longitude,
    required locationType,
    VoidCallback? onTap,
    double dimension = 35})
  {
    return Marker(
      width: dimension,
      height: dimension,
      point: LatLng(latitude, longitude),
      child: GestureDetector(
        onTap: onTap,
        child: CustomIcon.locationMarker(1, locationType),
      ),
    );
  }

  static Marker bike({
    required double latitude,
    required double longitude,
    required String bikeStatus,
    VoidCallback? onTap})
  {
    return Marker(
      width: 38,
      height: 38,
      point: LatLng(latitude, longitude),
      child: GestureDetector(
        onTap: onTap,
        child: CustomIcon.bikeMarker(1, bikeStatus),
      ),
    );
  }
}



////////////////
////////////////
// TODO: Remove the code below once no longer will be used.
////////////////
////////////////
List<Marker> buildMarkers(BuildContext context) {
      return [
    //FTMK
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3082, 102.3193),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3082, 102.3193), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //FTKEK
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3142, 102.3182),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3142, 102.3182), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //FTKP
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3079, 102.3209),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3079, 102.3209), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //FTKE
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3148, 102.3198),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3148, 102.3198), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Library
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3093, 102.3206),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3093, 102.3206), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Masjid
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3120, 102.3187),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3120, 102.3187), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),

    //Dewan Cansoler
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3140, 102.3214),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3140, 102.3214), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //HEPA
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.31315, 102.32091),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.31315, 102.32091), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Dewan Canselor
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.31135, 102.32235),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.31135, 102.32235), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //PPP
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.31015, 102.31875),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.31015, 102.31875), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Pusat Bahasa
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3094, 102.3194),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3094, 102.3194), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //PKU
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3100, 102.31755),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3100, 102.31755), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //PPPK
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.31085, 102.31935),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.31085, 102.31935), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //PPS
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.30665, 102.31912),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.30665, 102.31912), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Cafe 1
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3137, 102.3190),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3137, 102.3190), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Cafe 2
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3107, 102.31865),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3107, 102.31865), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Cafe 3
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3055, 102.3190),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3055, 102.3190), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Cafe Satria
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3104, 102.3150),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3104, 102.3150), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Cafe Lestari
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3152, 102.3161),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3152, 102.3161), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Sasana
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3114, 102.31855),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3114, 102.31855), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Pusat Sukan
    Marker(
        width: 40,
        height: 40,
        point: const LatLng(2.3168, 102.3207),
        child: GestureDetector(
            onTap: () {
              _onMarkerTap(const LatLng(2.3168, 102.3207), context);
            },
            child: CustomIcon.locationMarker(1, "Library")
        )),
    //Stadium
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3179, 102.3213),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3179, 102.3213), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Kolej Kasturi
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3110, 102.3147),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3110, 102.3147), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Kolej Lekiu
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3111, 102.3137),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3111, 102.3137), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Kolej Lekir
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3104, 102.3141),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3104, 102.3141), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Kolej Tuah
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3088, 102.3151),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3088, 102.3151), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Kolej Jebat
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3088, 102.3144),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3088, 102.3144), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Kolej Lestari (P)
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3146, 102.3161),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3146, 102.3161), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
    //Kolej Lestari (L)
    Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(2.3162, 102.3157),
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(const LatLng(2.3162, 102.3157), context);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        )),
  ];
}


void _onMarkerTap(LatLng latlng, BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows you to control the height
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return SizedBox(
        height: 250,
        child: DraggableScrollableSheet(
          initialChildSize: 0.8, // Adjust the initial height
          minChildSize: 0.6, // Minimum height of the modal
          maxChildSize: 0.9, // Maximum height of the modal
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller:
              scrollController, // Attach the controller for scroll behavior
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const ListTile(
                      title: Text('Information about the place'),
                      subtitle:
                      Text('Details about the location at'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the modal
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
