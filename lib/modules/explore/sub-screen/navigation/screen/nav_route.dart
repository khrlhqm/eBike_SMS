import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import '../../../../global_import.dart';

class NavRouteScreen extends StatefulWidget {
  final LatLng startWaypoint;
  final LatLng endWaypoint;

  const NavRouteScreen(
      {super.key, required this.startWaypoint, required this.endWaypoint});

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

  Future<void> _fetchRouteFromOSRM() async {
    final String osrmUrl = 'https://router.project-osrm.org/route/v1/bike/'
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
    return Container(
      color: ColorConstant.hintBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Starting point at: ${widget.startWaypoint}",
              style:
                  const TextStyle(fontSize: 16, color: ColorConstant.darkBlue)),
          Text("Pinpointing at: ${widget.endWaypoint}",
              style:
                  const TextStyle(fontSize: 16, color: ColorConstant.darkBlue)),
        ],
      ),
    );
  }
}
