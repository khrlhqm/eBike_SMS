import 'package:ebikesms/modules/global_import.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class NavRouteScreen extends StatefulWidget {
  final LatLng startWaypoint;
  final LatLng endWaypoint;

  const NavRouteScreen({
    super.key,
    required this.startWaypoint,
    required this.endWaypoint,
  });

  @override
  State<NavRouteScreen> createState() => _NavRouteScreenState();
}

class _NavRouteScreenState extends State<NavRouteScreen> {
  List<LatLng> routePoints = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRouteFromOSRM();
  }

  /// Fetch route geometry from OSRM API
  Future<void> _fetchRouteFromOSRM() async {
    final String osrmUrl = 'https://router.project-osrm.org/route/v1/driving/'
        '${widget.startWaypoint.longitude},${widget.startWaypoint.latitude};'
        '${widget.endWaypoint.longitude},${widget.endWaypoint.latitude}'
        '?overview=full&geometries=polyline';

    try {
      final response = await http.get(Uri.parse(osrmUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String encodedPolyline = data['routes'][0]['geometry'];

        // Decode the polyline into a list of LatLng
        setState(() {
          routePoints = _decodePolyline(encodedPolyline);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch route: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching route: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Decode polyline string into a list of LatLng
  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int result = 0, shift = 0;
      int byte;
      do {
        byte = polyline.codeUnitAt(index) - 63;
        index++;
        result |= (byte & 0x1f) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += deltaLat;

      shift = 0;
      result = 0;
      do {
        byte = polyline.codeUnitAt(index) - 63;
        index++;
        result |= (byte & 0x1f) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += deltaLng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Route'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(
                      (widget.startWaypoint.latitude +
                              widget.endWaypoint.latitude) /
                          2,
                      (widget.startWaypoint.longitude +
                              widget.endWaypoint.longitude) /
                          2,
                    ),
                    initialZoom: 13,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: routePoints,
                          strokeWidth: 4.0,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: widget.startWaypoint,
                          width: 80,
                          height: 80,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 40,
                          ),
                        ),
                        Marker(
                          point: widget.endWaypoint,
                          width: 80,
                          height: 80,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      final routeUrl = _generateRouteUrl();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('OSRM URL: $routeUrl')),
                      );
                    },
                    child: const Text('Generate OSRM Route URL'),
                  ),
                ),
              ],
            ),
    );
  }

  /// Generate the OSRM map URL
  String _generateRouteUrl() {
    if (routePoints.isEmpty) {
      throw ArgumentError("Route points cannot be empty");
    }

    // Construct the loc parameters
    final String locParams = routePoints
        .map((latLng) => "loc=${latLng.latitude}%2C${latLng.longitude}")
        .join("&");

    // Center the map on the first point
    final LatLng center = routePoints.first;

    // Build the final URL
    return "https://map.project-osrm.org/?z=14&center=${center.latitude}%2C${center.longitude}&$locParams&hl=en&alt=0&srv=1";
  }
}
