import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

List<Marker> buildMarkers() {
  return [
    //FTMK
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3082, 102.3193),
      child: Icon(
        Icons.location_on,
        color: Colors.blue,
        size: 40,
      ),
    ),
    //FTKEK
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3142, 102.3182),
      child: Icon(
        Icons.location_on,
        color: Colors.blue,
        size: 40,
      ),
    ),
    //FTKP
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3079, 102.3209),
      child: Icon(
        Icons.location_on,
        color: Colors.blue,
        size: 40,
      ),
    ),
    //FTKE
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3148, 102.3198),
      child: Icon(
        Icons.location_on,
        color: Colors.blue,
        size: 40,
      ),
    ),
    //Library
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3093, 102.3206),
      child: Icon(
        Icons.location_on,
        color: Colors.orange,
        size: 40,
      ),
    ),
    //Masjid
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3120, 102.3187),
      child: Icon(
        Icons.location_on,
        color: Colors.orange,
        size: 40,
      ),
    ),
    //Dewan Cansoler
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3140, 102.3214),
      child: Icon(
        Icons.location_on,
        color: Colors.orange,
        size: 40,
      ),
    ),
    //HEPA
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.31315, 102.32091),
      child: Icon(
        Icons.location_on,
        color: Colors.orange,
        size: 40,
      ),
    ),
    //Dewan Canselor
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.31135, 102.32235),
      child: Icon(
        Icons.location_on,
        color: Colors.orange,
        size: 40,
      ),
    ),
    //PPP
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.31015, 102.31875),
      child: Icon(
        Icons.location_on,
        color: Colors.purple,
        size: 40,
      ),
    ),
    //Pusat Bahasa
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3094, 102.3194),
      child: Icon(
        Icons.location_on,
        color: Colors.purple,
        size: 40,
      ),
    ),
    //PKU
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3100, 102.31755),
      child: Icon(
        Icons.location_on,
        color: Colors.purple,
        size: 40,
      ),
    ),
    //PPPK
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.31085, 102.31935),
      child: Icon(
        Icons.location_on,
        color: Colors.purple,
        size: 40,
      ),
    ),
    //PPS
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.30665, 102.31912),
      child: Icon(
        Icons.location_on,
        color: Colors.purple,
        size: 40,
      ),
    ),
    //Cafe 1
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3137, 102.3190),
      child: Icon(
        Icons.location_on,
        color: Colors.yellow,
        size: 40,
      ),
    ),
    //Cafe 2
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3107, 102.31865),
      child: Icon(
        Icons.location_on,
        color: Colors.yellow,
        size: 40,
      ),
    ),
    //Cafe 3
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3055, 102.3190),
      child: Icon(
        Icons.location_on,
        color: Colors.yellow,
        size: 40,
      ),
    ),
    //Cafe Satria
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3104, 102.3150),
      child: Icon(
        Icons.location_on,
        color: Colors.yellow,
        size: 40,
      ),
    ),
    //Cafe Lestari
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3152, 102.3161),
      child: Icon(
        Icons.location_on,
        color: Colors.yellow,
        size: 40,
      ),
    ),
    //Sasana
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3114, 102.31855),
      child: Icon(
        Icons.location_on,
        color: Colors.yellow,
        size: 40,
      ),
    ),
    //Pusat Sukan
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3168, 102.3207),
      child: Icon(
        Icons.location_on,
        color: Colors.green,
        size: 40,
      ),
    ),
    //Stadium
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3179, 102.3213),
      child: Icon(
        Icons.location_on,
        color: Colors.green,
        size: 40,
      ),
    ),
    //Kolej Kasturi
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3110, 102.3147),
      child: Icon(
        Icons.location_on,
        color: Colors.pink,
        size: 40,
      ),
    ),
    //Kolej Lekiu
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3111, 102.3137),
      child: Icon(
        Icons.location_on,
        color: Colors.pink,
        size: 40,
      ),
    ),
    //Kolej Lekir
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3104, 102.3141),
      child: Icon(
        Icons.location_on,
        color: Colors.pink,
        size: 40,
      ),
    ),
    //Kolej Tuah
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3088, 102.3151),
      child: Icon(
        Icons.location_on,
        color: Colors.pink,
        size: 40,
      ),
    ),
    //Kolej Jebat
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3088, 102.3144),
      child: Icon(
        Icons.location_on,
        color: Colors.pink,
        size: 40,
      ),
    ),
    //Kolej Lestari (P)
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3146, 102.3161),
      child: Icon(
        Icons.location_on,
        color: Colors.pink,
        size: 40,
      ),
    ),
    //Kolej Lestari (L)
    const Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(2.3162, 102.3157),
      child: Icon(
        Icons.location_on,
        color: Colors.pink,
        size: 40,
      ),
    ),
  ];
}
