import 'package:ebikesms/modules/explore/sub-screen/navigation/screen/nav_route.dart';
import 'package:ebikesms/modules/explore/widget/custom_marker.dart';
import 'package:ebikesms/modules/explore/widget/custom_map.dart';
import 'package:ebikesms/modules/explore/widget/map_side_buttons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../global_import.dart';

class NavConfirmPinpointScreen extends StatefulWidget {
  final List<dynamic> allLocations;
  const NavConfirmPinpointScreen({
    super.key,
    required this.allLocations
  });

  @override
  State<NavConfirmPinpointScreen> createState() => _NavConfirmPinpointScreenState();
}

class _NavConfirmPinpointScreenState extends State<NavConfirmPinpointScreen> {
  final MapController _mapController = MapController();
  final List<Marker> _allMarkers = [];
  final ValueNotifier<LatLng> _currentUserLatLng = ValueNotifier(MapConstant.initCenterPoint); // Initialize with default value
  bool _isMarkersLoaded = false;

  void _buildUserMarker() {
    _allMarkers.add(
      CustomMarker.user(
        latitude: _currentUserLatLng.value.latitude,
        longitude: _currentUserLatLng.value.longitude,
      ),
    );
    setState(() {
      _isMarkersLoaded = true;
    });
  }

  void _buildLocationMarkers() {
    if (widget.allLocations.isNotEmpty) {
      for (int i = 0; i < widget.allLocations.length; i++) {
        if (widget.allLocations[i]['latitude'] != null && widget.allLocations[i]['longitude'] != null) {
          double parsedLat = double.parse(widget.allLocations[i]['latitude']);
          double parsedLong = double.parse(widget.allLocations[i]['longitude']);
          _allMarkers.add(
            CustomMarker.location(
              latitude: parsedLat,
              longitude: parsedLong,
              locationType: widget.allLocations[i]['location_type'],
            ),
          );
        }
      }
    }
    setState(() {
      _isMarkersLoaded = true;
    });
  }

  void _fetchCurrentUserLocation() async {
    if(getLocationPermission() == false) return;

    // Fetch initial location
    try {
      setState(() {
        _isMarkersLoaded = false;
      });
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);
      _currentUserLatLng.value = currentLatLng;
      _buildUserMarker();
      _updateUserRealTime();
    }
    catch (e) {
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
        const SnackBar(content: Text('Location permissions are permanently denied.')),
      );
      return false;
    }
    return true;
  }

  void _updateUserRealTime() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // Minimum movement to trigger an update
      ),
    ).listen((Position position) {
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);
      _currentUserLatLng.value = currentLatLng;
      setState(() {
        // Remove the old User marker
        _allMarkers.removeWhere((marker) => marker.key == const ValueKey("user_marker"));

        // Add the updated User marker
        _allMarkers.add(
            CustomMarker.user(
                latitude: _currentUserLatLng.value.latitude,
                longitude: _currentUserLatLng.value.longitude
            )
        );
      });
    }, onError: (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error receiving location updates: $e')),
      );
    });
  }

  Widget _displayPinpointOrLoading(bool hasMarkersLoaded) {
    return Center(
        child: (hasMarkersLoaded)
            ? Padding(
          padding: const EdgeInsets.only(bottom: 35),
          child: CustomIcon.pinpointColoured(35),
        )
            : Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              color: ColorConstant.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: ColorConstant.shadow, // Shadow color
                    offset: Offset(0, 2),                 // Shadow position
                    blurRadius: 10.0,                      // Spread of the shadow
                    spreadRadius: 0.0                     // Additional spread
                )
              ]
          ),
          child: const LoadingAnimation(dimension: 30),
        )
    );
  }

  @override
  void initState() {
    super.initState();
    _buildLocationMarkers();
    _fetchCurrentUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.centerRight,
        children: [
          // Custom map display
          ValueListenableBuilder<LatLng>(
            valueListenable: _currentUserLatLng, // Listen to the ValueNotifier
            builder: (context, latlng, widget) {
              return CustomMap(
                mapController: _mapController,
                allMarkers: _allMarkers,
                initialCenter: MapConstant.initCenterPoint,
                enableInteraction: true,
              );
            },
          ),

          // Back button
          const Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                          child: CustomCircularBackButton()
                      ),
                    ],
                  ),
                ],
              )
          ),

          // Map Side Buttons
          MapSideButtons(
              mapController: _mapController,
              currentUserLocation: _currentUserLatLng.value,
              showGuideButton: false
          ),

          // Markers on the map (using the same
          _displayPinpointOrLoading(_isMarkersLoaded),

          // Confirm button
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(40, 10, 40, 30),
                child: CustomRectangleButton(
                  label: "Confirm",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context)=> NavRouteScreen(
                          startWaypoint: LatLng(_currentUserLatLng.value.latitude, _currentUserLatLng.value.longitude),
                          endWaypoint: _mapController.camera.center
                        )
                      )
                    );
                  },
                )
              )
            ],
          ),
      ])
    );
  }
}
