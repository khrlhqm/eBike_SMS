import 'package:ebikesms/modules/learn/screen/learn.dart';
import 'package:ebikesms/modules/global_import.dart';
import 'package:ebikesms/shared/utils/shared_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../controller/location_controller.dart';

class ExploreScreen extends StatefulWidget {
  final SharedState sharedState;
  const ExploreScreen(this.sharedState, {super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final MapController _mapController = MapController();
  late List<dynamic> _allLocations;
  late List<dynamic> _allBikeLocations; // TODO
  late Position _currentUserLocation;
  List<Marker> _allMarkers = [];
  bool _isMarkersLoaded = false;

  Widget _displayMap() {
    _allMarkers.length;
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: LocationConstant.initialCenter,
        initialZoom: 16.0,
        interactionOptions: InteractionOptions(flags: InteractiveFlag.all),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(markers: _allMarkers),
      ],
    );
  }

  void _buildMarkers(String type) {
    _isMarkersLoaded = false;
    try {
      switch (type) {
        case "Location":
          if (_allLocations.isNotEmpty) {
            for (int i = 0; i < _allLocations.length; i++) {
              final location = _allLocations[i];
              if (location['latitude'] != null &&
                  location['longitude'] != null) {
                double parsedLat = double.parse(location['latitude']);
                double parsedLong = double.parse(location['longitude']);
                _allMarkers.add(
                  Marker(
                    width: 40,
                    height: 40,
                    point: LatLng(parsedLat, parsedLong),
                    child: GestureDetector(
                      onTap: () => _onLocationMarkerTap(i),
                      child: CustomIcon.locationMarker(
                          1, location['location_type']),
                    ),
                  ),
                );
              }
            }
          }
          break;

        case "Bike":
          // TODO: Fetch bike markers and add to _allMarkers
          break;

        case "User":
          if (_currentUserLocation != null) {
            _allMarkers.add(
              Marker(
                width: 20,
                height: 20,
                point: LatLng(_currentUserLocation.latitude,
                    _currentUserLocation.longitude),
                child: CustomIcon.userMarker(1),
              ),
            );
          }
          break;
        default:
          break;
      }
    } catch (e) {
      print("Error building markers: $e");
    }
    setState(() {
      _isMarkersLoaded = true;
    });
  }

  void _fetchLocations() async {
    var results = await LocationController.getLocations();
    if (results['status'] == 0) {
      // Failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Status: ${results['status']}, Message: ${results['message']}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Status: ${results['status']}, Message: ${results['message']}")),
      );
    }
    _allLocations = results['data'];
    _buildMarkers("Location");
  }

  void _fetchCurrentUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
    }

    // Request permissions if needed
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied.')),
        );
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')),
      );
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _currentUserLocation = position;
      _buildMarkers("User");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpectedly failed to fetch location: $e')),
      );
    }
  }

  void _pointToUserLocation() async {
    setState(() {
      _mapController.move(
          LatLng(_currentUserLocation.latitude, _currentUserLocation.longitude),
          16.0);
    });
  }

  void _onLocationMarkerTap(int index) {
    // Update these values to make marker card visible and it's details
    widget.sharedState.markerCardState.value = MarkerCardState.location;
    widget.sharedState.markerCardVisibility.value = true;
    widget.sharedState.locationNameMalay.value =
        _allLocations[index]['location_name_malay'];
    widget.sharedState.locationNameEnglish.value =
        _allLocations[index]['location_name_english'];
    widget.sharedState.locationType.value =
        _allLocations[index]['location_type'];
    widget.sharedState.address.value = _allLocations[index]['address'];
    // widget.sharedState.latitude.value = _allLocations[index]['latitude'];
    // widget.sharedState.longitude.value = _allLocations[index]['longitude'];
    //
  }

  void _onBikeMarkerTap(int index) {
    // TODO: Update these values to make marker card visible and it's details
  }

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserLocation();
    _fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.centerRight,
        children: [
          // Map background
          _displayMap(),
          // Loading Animation
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
              ))),
          // Pinpoint-user and learn buttons
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _pointToUserLocation,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                      backgroundColor: ColorConstant.white, // Background color
                      shadowColor: ColorConstant.black, // Box shadow color
                      elevation: 5,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: CustomIcon.crosshairColoured(25),
                    )),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LearnScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.zero,
                    backgroundColor: ColorConstant.white,
                    shadowColor: ColorConstant.black,
                    elevation: 5,
                    minimumSize: const Size(54, 55), // Directly set size here
                  ),
                  child: CustomIcon.learnColoured(30),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
