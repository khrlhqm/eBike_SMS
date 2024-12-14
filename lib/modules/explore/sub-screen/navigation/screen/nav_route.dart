import 'package:latlong2/latlong.dart';

import '../../../../global_import.dart';

class NavRouteScreen extends StatefulWidget {
  final LatLng startWaypoint;
  final LatLng endWaypoint;

  const NavRouteScreen({
    super.key,
    required this.startWaypoint,
    required this.endWaypoint
  });

  @override
  State<NavRouteScreen> createState() => _NavRouteScreenState();
}

class _NavRouteScreenState extends State<NavRouteScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstant.hintBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "Starting point at: ${widget.startWaypoint}",
              style: TextStyle(fontSize: 16, color: ColorConstant.darkBlue)
          ),
          Text(
              "Pinpointing at: ${widget.endWaypoint}",
              style: TextStyle(fontSize: 16, color: ColorConstant.darkBlue)
          ),
        ],
      ),
    );
  }
}
