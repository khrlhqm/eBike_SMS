import 'package:ebikesms/modules/global_import.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

Future<void> fetchDirections(LatLng start, LatLng end) async {
  String url =
      MappingAPIBase.buildRouteUrl(TextConstant.cyclingUrl, start, end);

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    print("Route Data: ${response.body}");
  } else {
    print("Error: ${response.body}");
  }
}
