import 'package:ebikesms/modules/learn/screen/learn.dart';
import 'package:ebikesms/modules/global_import.dart';
import 'package:ebikesms/modules/explore/widget/marker.dart';
import 'package:ebikesms/shared/utils/shared_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../shared/widget/bottom_nav_bar.dart';
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
  late List<dynamic> _allBikeLocations;
  late List<Marker> _markers;
  late Position _currentPosition;

  void _fetchUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Request permissions if needed
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // If permissions are permanently denied, return error
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      // Get the current position if permission is granted
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _buildMarkers(); // Call to rebuild the markers based on new position
      });
    } catch (e) {
      return Future.error('Failed to fetch location: $e');
    }
  }

  void _fetchLocations() async {
    var results = await LocationController.getLocations();
    if(results['status'] == 0) { // Failed
      return;  // TODO: Handle API response
    }
    setState(() {
      _allLocations = results['data'];
    });
  }

  void _pointToCurrentLocation() async {
    setState(() {
      _mapController.move(LatLng(_currentPosition.latitude, _currentPosition.longitude), 16.0);
    });
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text("Moved to current ExploreScreen")),
    // );
  }
  
  TileLayer get _getOpenStreetMap => TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  );

  Widget _displayMap() {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: LocationConstant.initialCenter,
        initialZoom: 16.0,
        interactionOptions: InteractionOptions(flags: InteractiveFlag.all),
      ),
      children: [
        _getOpenStreetMap,
        MarkerLayer(markers: _markers),
      ],
    );
  }

  void _buildMarkers() {
    List<Marker> markerList = [];
    // LOCATION MARKERS
    for (int i = 0; i < 1; i++) {
      markerList.add(
        Marker(
          width: 40,
          height: 40,
          // point: LatLng(_allLocations[i]['latitude'], _allLocations[i]['longitude']), TODO: Uncomment this
          point: LocationConstant.initialCenter,
          child: GestureDetector(
            onTap: () => _onLocationMarkerTap(i),
            child: CustomIcon.locationMarker(1, "Coffee Shop")
          )
        ),
      );
    }

    // BIKE MARKERS
    // TODO: Fetch bike markers and add to list


    // USER MARKER
    markerList.add(Marker(
      width: 20,
      height: 20,
      point: LatLng(_currentPosition.latitude, _currentPosition.longitude),
      child: CustomIcon.userMarker(1)
    ));

    setState(() {
      _markers = markerList;
    });
  }

  void _onLocationMarkerTap(int index) {
    widget.sharedState.markerCardState.value = MarkerCardState.location;
    widget.sharedState.markerCardVisibility.value = true;
    // sharedState.locationNameMalay.value = _allLocations[index]['location_name_malay'];
    // sharedState.locationNameEnglish.value = _allLocations[index]['location_name_english'];
    // sharedState.locationType.value = _allLocations[index]['location_type'];
    // sharedState.address.value = _allLocations[index]['address'];
    // TODO: Uncomment these when locations are available
  }

  void _onBikeMarkerTap(int index) {
    // TODO:
  }

  @override
  void initState() {
    super.initState();
    _markers = [];
    _fetchUserLocation();
    _fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.centerRight,
        children: [
          _displayMap(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _pointToCurrentLocation,
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
                  )
                ),
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


