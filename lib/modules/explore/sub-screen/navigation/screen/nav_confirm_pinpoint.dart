import '../../../../global_import.dart';

class NavConfirmPinpoint extends StatefulWidget {
  const NavConfirmPinpoint({super.key});

  @override
  State<NavConfirmPinpoint> createState() => _NavConfirmPinpointState();
}

class _NavConfirmPinpointState extends State<NavConfirmPinpoint> {
  final MapController _mapController = MapController();

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
        //MarkerLayer(markers: _markers),
      ],
    );
  }

  TileLayer get _getOpenStreetMap => TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
        alignment: Alignment.centerRight,
        children: [
        _displayMap(),

      ])
    );
  }
}
