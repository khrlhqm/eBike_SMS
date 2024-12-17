import 'package:ebikesms/modules/explore/sub-screen/navigation/screen/nav_route.dart';
import 'package:ebikesms/modules/explore/widget/marker_card.dart';
import 'package:ebikesms/shared/widget/rectangle_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../global_import.dart';

class NavConfirmSelectedScreen extends StatefulWidget {
  //final List<dynamic> allLocations;
  final Map<String, dynamic> selectedLocation;
  const NavConfirmSelectedScreen({
    super.key,
    //required this.allLocations,
    required this.selectedLocation
  });

  @override
  State<NavConfirmSelectedScreen> createState() => _NavConfirmSelectedScreenState();
}

class _NavConfirmSelectedScreenState extends State<NavConfirmSelectedScreen> {
  final MapController _mapController = MapController();
  final List<Marker> _allMarkers = [];
  final ValueNotifier<LatLng> _currentUserLatLng = ValueNotifier(const LatLng(0.0, 0.0)); // Initialize with default value
  bool _isMarkersLoaded = false;

  Widget _displayMap() {
    double initLat = double.parse(widget.selectedLocation['latitude']);
    double initLong = double.parse(widget.selectedLocation['longitude']);
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: LatLng(initLat, initLong),
        initialZoom: 16.0,
      ),
      children: [
        _getOpenStreetMap,
        MarkerLayer(markers: _allMarkers),
      ],
    );
  }

  TileLayer get _getOpenStreetMap => TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  );

  void _buildMarkers(String type) {
    try {
      switch (type) {
        case "User":
          _allMarkers.add(
            Marker(
              key: const ValueKey("user_marker"),
              width: 20,
              height: 20,
              point: LatLng(_currentUserLatLng.value.latitude, _currentUserLatLng.value.longitude),
              child: CustomIcon.userMarker(1),
            ),
          );
          break;
        case "Location":
          double parsedLat = double.parse(widget.selectedLocation['latitude']);
          double parsedLong = double.parse(widget.selectedLocation['longitude']);
          debugPrint("widget.selectedLocation['longitude']: ${widget.selectedLocation['longitude']}");
          _allMarkers.add(
            Marker(
              width: 40,
              height: 40,
              point: LatLng(parsedLat, parsedLong),
              child: CustomIcon.locationMarker(1, widget.selectedLocation['location_type']),
            ),
          );
        default:
          break;
      }
    } catch (e) {
      print("Error building markers: $e");
    }
    setState(() {});
  }

  void _fetchCurrentUserLocation() async {
    if(getLocationPermission() == false) return;
    // Fetch initial location
    try {
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _currentUserLatLng.value = LatLng(pos.latitude, pos.longitude);
      _buildMarkers("User");
      _buildMarkers("Location");
      _isMarkersLoaded = true;
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

  void _pointToUserLocation() {
    setState(() {
      _mapController.move(LatLng(_currentUserLatLng.value.latitude, _currentUserLatLng.value.longitude), 16.0);
    });
  }

  void _alignMapLocation() {
    setState(() {
      _mapController.rotate(0.0);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
              _displayMap(),
              _displayBackButton(),
              _displayLoading(),
              _displayMapButtons(),
              MarkerCard(
                markerCardState: MarkerCardState.location,
                navigationButtonEnable: false,
                locationNameMalay: widget.selectedLocation['location_name_malay'],
                locationNameEnglish: widget.selectedLocation['location_name_english'],
                locationType: widget.selectedLocation['location_type'],
                address: widget.selectedLocation['address'],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                margin: const EdgeInsets.fromLTRB(40, 10, 40, 30),
                child: RectangleButton(
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
            ]
        )
    );
  }

  Widget _displayBackButton() {
    return Expanded(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () { Navigator.pop(context); },
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
        )
    );
  }

  Widget _displayLoading() {
    return Visibility(
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
                    offset: Offset(0, 2),                 // Shadow position
                    blurRadius: 10.0,                      // Spread of the shadow
                    spreadRadius: 0.0                     // Additional spread
                )
              ]
          ),
          child: const LoadingAnimation(dimension: 30),
        )
      ),
    );
  }

  Widget _displayMapButtons() {
    return Expanded(
      child:
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _alignMapLocation,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                      backgroundColor: ColorConstant.white, // Background color
                      shadowColor: ColorConstant.lightGrey, // Box shadow color
                      elevation: 2,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomIcon.compassColoured(30),
                    ),
                  ),
                  const SizedBox(height: 13),
                  ElevatedButton(
                      onPressed: _pointToUserLocation,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: EdgeInsets.zero,
                        backgroundColor: ColorConstant.white, // Background color
                        shadowColor: ColorConstant.lightGrey, // Box shadow color
                        elevation: 2,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: CustomIcon.crosshairColoured(25),
                      )
                  ),
                ],
              ),
            ),
          ]
        ),
    );
  }
}
