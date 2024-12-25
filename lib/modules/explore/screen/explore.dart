import 'dart:core';

import 'package:ebikesms/modules/explore/controller/bike_data_controller.dart';
import 'package:ebikesms/modules/explore/widget/custom_marker.dart';
import 'package:ebikesms/modules/explore/widget/map_side_buttons.dart';
import 'package:ebikesms/modules/learn/screen/learn.dart';
import 'package:ebikesms/modules/global_import.dart';
import 'package:ebikesms/shared/utils/shared_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../controller/location_controller.dart';
import '../widget/custom_map.dart';

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
  late ValueNotifier<LatLng> _currentUserLatLng = ValueNotifier(LatLng(0, 0));
  final List<Marker> _allMarkers = [];
  bool _isMarkersLoaded = false;

  void _buildLocationMarkers() {
    if (_allLocations.isNotEmpty) {
      for (int i = 0; i < _allLocations.length; i++) {
        if (_allLocations[i]['latitude'] != null && _allLocations[i]['longitude'] != null) {
          double parsedLat = double.parse(_allLocations[i]['latitude']);
          double parsedLong = double.parse(_allLocations[i]['longitude']);
          _allMarkers.add(
            CustomMarker.location(
              latitude: parsedLat,
              longitude: parsedLong,
              locationType: _allLocations[i]['location_type'],
              onTap: () => _onTapLocationMarker(i),
            ),
          );
        }
      }
    }
    setState(() {
      _isMarkersLoaded = true;
    });
  }

  void _buildBikeMarkers() {
    if (_allBikes.isNotEmpty) {
      for (int i = 0; i < _allBikes.length; i++) {
        if (_allBikes[i]['current_latitude'] != null && _allBikes[i]['current_longitude'] != null) {
          double parsedLat = double.parse(_allBikes[i]['current_latitude']);
          double parsedLong = double.parse(_allBikes[i]['current_longitude']);
          // Ignoring bikes that have "Riding" status
          if (_allBikes[i]['status'] != "Riding") {
            _allMarkers.add(
              CustomMarker.bike(
                latitude: parsedLat,
                longitude: parsedLong,
                bikeStatus: _allBikes[i]['status'],
                onTap: () => _onTapBikeMarker(i),
              ),
            );
          }
        }
      }
    }
    setState(() {
      _isMarkersLoaded = true;
    });
  }

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

  void _fetchLocations() async {
    setState(() {
      _isMarkersLoaded = false;
    });
    var results = await LocationController.getLocations();
    if(results['status'] == 0) { // Failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Status: ${results['status']}, Message: ${results['message']}")),
      );
    }
    _allLocations = results['data'];
    _buildLocationMarkers();
  }

  void _fetchBikes() async {
    setState(() {
      _isMarkersLoaded = false;
    });
    var results = await BikeDataController.getBikes();
    if(results['status'] == 0) { // Failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Status: ${results['status']}, Message: ${results['message']}")),
      );
    }
    _allBikes = results['data'];
    _buildBikeMarkers();
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

  void _onTapLocationMarker(int index) {
    // Update these values to make marker card visible and it's details
    widget.sharedState.markerCardState.value = MarkerCardState.location;
    widget.sharedState.locationNameMalay.value = _allLocations[index]['location_name_malay'];
    widget.sharedState.locationNameEnglish.value = _allLocations[index]['location_name_english'];
    widget.sharedState.locationType.value = _allLocations[index]['location_type'];
    widget.sharedState.address.value = _allLocations[index]['address'];
    widget.sharedState.locationLatitude.value = double.parse(_allLocations[index]['latitude']);
    widget.sharedState.locationLongitude.value = double.parse(_allLocations[index]['longitude']);

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
    widget.sharedState.bikeCurrentLatitude.value = double.parse(_allBikes[index]['current_latitude']) ;
    widget.sharedState.bikeCurrentLongitude.value = double.parse(_allBikes[index]['current_longitude']);

    // Must set to false first, then true again to make sure ValueListenableBuilder of MarkerCard listens
    widget.sharedState.markerCardVisibility.value = false;
    widget.sharedState.markerCardVisibility.value = true;
    // This is not redundant code. (Though it can be improved)
  }

  @override
  void initState() {
    super.initState();
    _fetchLocations();
    _fetchBikes();
    _fetchCurrentUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.centerRight,
        children: [
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

          // Map Side Buttons
          MapSideButtons(
              mapController: _mapController,
              currentUserLocation: _currentUserLatLng.value,
              showGuideButton: true
          ),

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
                          offset: Offset(0, 2),                 // Shadow position
                          blurRadius: 10.0,                      // Spread of the shadow
                          spreadRadius: 0.0                     // Additional spread
                      )
                    ]
                ),
                child: const LoadingAnimation(dimension: 30),
              )
            )
          ),
          // Pinpoint-user and learn buttons
        ],
      ),
    );
  }
}

