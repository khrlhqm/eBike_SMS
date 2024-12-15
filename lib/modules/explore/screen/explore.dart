import 'package:ebikesms/modules/explore/controller/bike_data_controller.dart';
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
  late List<dynamic> _allBikes;
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
              if (_allLocations[i]['latitude'] != null &&
                  _allLocations[i]['longitude'] != null) {
                double parsedLat = double.parse(_allLocations[i]['latitude']);
                double parsedLong = double.parse(_allLocations[i]['longitude']);
                _allMarkers.add(
                  Marker(
                    width: 40,
                    height: 40,
                    point: LatLng(parsedLat, parsedLong),
                    child: GestureDetector(
                      onTap: () => _onTapLocationMarker(i),
                      child: CustomIcon.locationMarker(
                          1, _allLocations[i]['location_type']),
                    ),
                  ),
                );
              }
            }
          }
          break;

        case "Bike":
          if (_allBikes.isNotEmpty) {
            for (int i = 0; i < _allBikes.length; i++) {
              if (_allBikes[i]['current_latitude'] != null &&
                  _allBikes[i]['current_longitude'] != null) {
                double parsedLat =
                    double.parse(_allBikes[i]['current_latitude']);
                double parsedLong =
                    double.parse(_allBikes[i]['current_longitude']);
                _allMarkers.add(
                  Marker(
                    width: 40,
                    height: 40,
                    point: LatLng(parsedLat, parsedLong),
                    child: GestureDetector(
                      onTap: () => _onTapBikeMarker(i),
                      child: CustomIcon.bikeMarker(1, _allBikes[i]['status']),
                    ),
                  ),
                );
              }
            }
          }
          break;

        case "User":
          _allMarkers.add(
            Marker(
              key: const ValueKey("user_marker"),
              width: 20,
              height: 20,
              point: LatLng(_currentUserLocation.latitude,
                  _currentUserLocation.longitude),
              child: CustomIcon.userMarker(1),
            ),
          );
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
    }
    _allLocations = results['data'];
    _buildMarkers("Location");
  }

  void _fetchBikes() async {
    var results = await BikeDataController.getBikes();
    if (results['status'] == 0) {
      // Failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Status: ${results['status']}, Message: ${results['message']}")),
      );
    }
    _allBikes = results['data'];
    _buildMarkers("Bike");
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

  void _fetchCurrentUserLocation() async {
    if (getLocationPermission() == false) return;

    // Fetch initial location
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _currentUserLocation = position;
      _buildMarkers("User");
      _updateUserRealTime();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch location: $e')),
      );
    }
  }

  void _updateUserRealTime() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // Minimum movement to trigger an update
      ),
    ).listen((Position position) {
      _currentUserLocation = position;
      _updateUserMarker();
    }, onError: (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error receiving location updates: $e')),
      );
    });
  }

  void _updateUserMarker() {
    setState(() {
      // Remove the old User marker
      _allMarkers
          .removeWhere((marker) => marker.key == const ValueKey("user_marker"));

      // Add the updated User marker
      _allMarkers.add(
        Marker(
          width: 20,
          height: 20,
          point: LatLng(
              _currentUserLocation.latitude, _currentUserLocation.longitude),
          child: CustomIcon.userMarker(1),
        ),
      );
    });
  }

  void _pointToUserLocation() {
    setState(() {
      _mapController.move(
          LatLng(_currentUserLocation.latitude, _currentUserLocation.longitude),
          16.0);
    });
  }

  void _alignMapLocation() {
    setState(() {
      _mapController.rotate(0.0);
    });
  }

  void _onTapLocationMarker(int index) {
    // Update these values to make marker card visible and it's details
    widget.sharedState.markerCardState.value = MarkerCardState.location;
    widget.sharedState.locationNameMalay.value =
        _allLocations[index]['location_name_malay'];
    widget.sharedState.locationNameEnglish.value =
        _allLocations[index]['location_name_english'];
    widget.sharedState.locationType.value =
        _allLocations[index]['location_type'];
    widget.sharedState.address.value = _allLocations[index]['address'];
    widget.sharedState.locationLatitude.value =
        double.parse(_allLocations[index]['latitude']);
    widget.sharedState.locationLongitude.value =
        double.parse(_allLocations[index]['longitude']);

    // Must set to false first, then true again to make sure ValueListenableBuilder of MarkerCard listens
    widget.sharedState.markerCardVisibility.value = false;
    widget.sharedState.markerCardVisibility.value = true;
    // This is not redundant code. (Though it can be improved)
  }

  void _onTapBikeMarker(int index) {
    // Update these values to make marker card visible and it's details
    widget.sharedState.markerCardState.value = MarkerCardState.scanBike;
    widget.sharedState.bikeId.value = _allBikes[index]['bike_id'];
    widget.sharedState.bikeStatus.value = _allBikes[index]['status'];
    widget.sharedState.bikeCurrentLatitude.value =
        double.parse(_allBikes[index]['current_latitude']);
    widget.sharedState.bikeCurrentLongitude.value =
        double.parse(_allBikes[index]['current_longitude']);

    // Must set to false first, then true again to make sure ValueListenableBuilder of MarkerCard listens
    widget.sharedState.markerCardVisibility.value = false;
    widget.sharedState.markerCardVisibility.value = true;
    // This is not redundant code. (Though it can be improved)
  }

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserLocation();
    _fetchLocations();
    _fetchBikes();
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
                    )),
                const SizedBox(height: 13),
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
                    shadowColor: ColorConstant.lightGrey,
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
