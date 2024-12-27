import 'package:ebikesms/modules/explore/sub-screen/navigation/screen/nav_route.dart';
import 'package:ebikesms/modules/explore/widget/custom_map.dart';
import 'package:ebikesms/modules/explore/widget/custom_marker.dart';
import 'package:ebikesms/modules/explore/widget/custom_warning_border.dart';
import 'package:ebikesms/modules/explore/widget/marker_card.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../global_import.dart';
import '../../../widget/map_side_buttons.dart';

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
  final List<Marker> _allMarkers = [];
  final ValueNotifier<LatLng> _currentUserLatLng =
      ValueNotifier(const LatLng(0.0, 0.0)); // Initialize with default value
  bool _isMarkersLoaded = false;

  void _buildUserMarker() {
    _allMarkers.add(CustomMarker.user(
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
    _allMarkers.add(CustomMarker.location(
        latitude: parsedLat,
        longitude: parsedLong,
        locationType: widget.selectedLocation['location_type']));
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
        SnackBar(content: Text('Failed to fetch location: $e')),
      );
    }
  }

  Future<bool> getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Check location services and permissions
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

  @override
  void initState() {
    super.initState();
    _buildSelectedLocationMarker();
    _fetchCurrentUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    double selectedLat = double.parse(widget.selectedLocation['latitude']);
    double selectedLong = double.parse(widget.selectedLocation['longitude']);
    return Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: [
      CustomMap(
        mapController: _mapController,
        allMarkers: _allMarkers,
        initialCenter: LatLng(selectedLat, selectedLong),
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
        markerCardState: MarkerCardState.location,
        navigationButtonEnable: false,
        locationNameMalay: widget.selectedLocation['location_name_malay'],
        locationNameEnglish: widget.selectedLocation['location_name_english'],
        locationType: widget.selectedLocation['location_type'],
        address: widget.selectedLocation['address'],
      ),

      // Confirm Button
      Container(
          width: MediaQuery.of(context).size.width * 0.7,
          margin: const EdgeInsets.fromLTRB(40, 10, 40, 30),
          child: CustomRectangleButton(
            label: "Confirm",
            onPressed: () {
              _showPopup(context, true);
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => NavRouteScreen(
              //             startWaypoint: LatLng(
              //                 _currentUserLatLng.value.latitude,
              //                 _currentUserLatLng.value.longitude),
              //             endWaypoint: _mapController.camera.center)));
            },
          ))
    ]));
  }
}

void _showPopup(BuildContext context, bool isWarning) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent, // Transparent background
      elevation: 0,
      child: PopupMessage(
        icon: isWarning ? Icons.warning_amber_rounded : Icons.error_outline,
        iconColor: isWarning ? Colors.yellow : Colors.red,
        title: isWarning ? "You entering the border." : "BORDER CROSSED",
        message: isWarning
            ? "Do not cross the marked borders. Violations will be reported."
            : "Please return the bike to safe zone immediately.",
        backgroundColor: isWarning ? Colors.black87 : Colors.red,
      ),
    ),
  );
}
