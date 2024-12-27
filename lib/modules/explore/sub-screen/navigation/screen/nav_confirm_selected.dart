import 'package:ebikesms/modules/explore/sub-screen/navigation/screen/nav_route.dart';
import 'package:ebikesms/modules/explore/widget/custom_map.dart';
import 'package:ebikesms/modules/explore/widget/custom_marker.dart';
import 'package:ebikesms/modules/explore/widget/marker_card.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../shared/utils/shared_state.dart';
import '../../../../global_import.dart';

class NavConfirmSelectedScreen extends StatefulWidget {
  //final List<dynamic> allLocations;
  final Map<String, dynamic> selectedLocation;
  const NavConfirmSelectedScreen(
      {super.key,
      //required this.allLocations,
      required this.selectedLocation});

  @override
  State<NavConfirmSelectedScreen> createState() =>
      _NavConfirmSelectedScreenState();
}

class _NavConfirmSelectedScreenState extends State<NavConfirmSelectedScreen> {
  final MapController _mapController = MapController();
  final ValueNotifier<LatLng> _currentUserLatLng =
      ValueNotifier(const LatLng(0.0, 0.0)); // Initialize with default value
  bool _isMarkersLoaded = false;

  @override
  void initState() {
    super.initState();
    SharedState.visibleMarkers.value
        .clear(); // Clear the markers before reinitializing again (avoid marker duplication)
    _buildSelectedLocationMarker();
    _fetchCurrentUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    double selectedLat = double.parse(widget.selectedLocation['latitude']);
    double selectedLong = double.parse(widget.selectedLocation['longitude']);
    return Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: [
      // Map background
      CustomMap(
        mapController: _mapController,
        allMarkers: SharedState.visibleMarkers,
        initialCenter: LatLng(selectedLat, selectedLong),
        initialZoom: MapConstant.focusZoomLevel,
        enableInteraction: false,
      ),

      // Back Button
      Expanded(
          child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                    backgroundColor: ColorConstant.white, // Background color
                    shadowColor: ColorConstant.lightGrey, // Box shadow color
                    elevation: 3,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomIcon.back(25, color: ColorConstant.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),

      // Loading Animation (if markers is not loaded yet)
      Visibility(
        visible: !_isMarkersLoaded,
        child: Center(
            child: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              color: ColorConstant.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: ColorConstant.shadow, // Shadow color
                    offset: Offset(0, 2), // Shadow position
                    blurRadius: 10.0, // Spread of the shadow
                    spreadRadius: 0.0 // Additional spread
                    )
              ]),
          child: const LoadingAnimation(dimension: 30),
        )),
      ),

      // Location Marker Card
      MarkerCard(
        markerCardState: MarkerCardContent.landmark,
        landmarkNameMalay: widget.selectedLocation['landmark_name_malay'],
        landmarkNameEnglish: widget.selectedLocation['landmark_name_english'],
        landmarkType: widget.selectedLocation['landmark_type'],
        landmarkAddress: widget.selectedLocation['address'],
      ),

      // Confirm Button
      Container(
          width: MediaQuery.of(context).size.width * 0.7,
          margin: const EdgeInsets.fromLTRB(40, 10, 40, 30),
          child: CustomRectangleButton(
            label: "Confirm",
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NavRouteScreen(
                          startWaypoint: LatLng(
                              _currentUserLatLng.value.latitude,
                              _currentUserLatLng.value.longitude),
                          endWaypoint: _mapController.camera.center)));
            },
          ))
    ]));
  }

  void _buildUserMarker() {
    SharedState.visibleMarkers.value.add(CustomMarker.user(
        latitude: _currentUserLatLng.value.latitude,
        longitude: _currentUserLatLng.value.longitude));
    setState(() {
      _isMarkersLoaded = true;
    });
  }

  void _buildSelectedLocationMarker() {
    double parsedLat = double.parse(widget.selectedLocation['latitude']);
    double parsedLong = double.parse(widget.selectedLocation['longitude']);
    debugPrint(
        "widget.selectedLocation['longitude']: ${widget.selectedLocation['longitude']}");
    SharedState.visibleMarkers.value.add(CustomMarker.landmark(
        latitude: parsedLat,
        longitude: parsedLong,
        landmarkType: widget.selectedLocation['landmark_type']));
    setState(() {
      _isMarkersLoaded = true;
    });
  }

  void _fetchCurrentUserLocation() async {
    if (getLocationPermission() == false) return;
    // Fetch initial location
    try {
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _currentUserLatLng.value = LatLng(pos.latitude, pos.longitude);
      _buildUserMarker();
      _isMarkersLoaded = true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch user location: $e')),
      );
    }
  }

  Future<bool> getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Check device location services and permissions
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied.')),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Location permissions are permanently denied.')),
      );
      return false;
    }
    return true;
  }
}
