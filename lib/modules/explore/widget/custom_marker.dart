import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../shared/utils/custom_icon.dart';

class CustomMarker extends Marker{
  CustomMarker({required super.point, required super.child});

  // Singular Markers (User and riding)
  static Marker user({
    required double latitude,
    required double longitude})
  {
    return Marker(
      key: const ValueKey("user_marker"),
      width: 20,
      height: 20,
      point: LatLng(latitude, longitude),
      child: CustomIcon.userMarker(1),
    );
  }


  // Singular Markers (User and riding)
  static Marker riding({
    required double latitude,
    required double longitude,
    VoidCallback? onTap})
  {
    return Marker(
      key: const ValueKey("riding_marker"),
      width: 35,
      height: 35,
      point: LatLng(latitude, longitude),
      child: CustomIcon.ridingMarker(1),
    );
  }

  // Multiple Markers (Landmarks & Bikes)
  static Marker landmark({
    required double latitude,
    required double longitude,
    required String landmarkType,
    int index = 0,
    VoidCallback? onTap,
    double dimension = 35})
  {
    return Marker(
      key: ValueKey("landmark_marker_$index"),
      width: dimension,
      height: dimension,
      point: LatLng(latitude, longitude),
      child: GestureDetector(
        onTap: onTap,
        child: CustomIcon.landmarkMarker(1, landmarkType),
      ),
    );
  }


  // Multiple Markers (Landmarks & Bikes)
  static Marker bike({
    required double latitude,
    required double longitude,
    required String bikeStatus,
    int index = 0,
    VoidCallback? onTap})
  {
    return Marker(
      key: ValueKey("bike_marker_$index"),
      width: 38,
      height: 38,
      point: LatLng(latitude, longitude),
      child: GestureDetector(
        onTap: onTap,
        child: CustomIcon.bikeMarker(1, bikeStatus),
      ),
    );
  }
}