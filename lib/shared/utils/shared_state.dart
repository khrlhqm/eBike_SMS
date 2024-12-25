import 'dart:async';

import 'package:ebikesms/modules/explore/widget/custom_marker.dart';
import 'package:flutter/material.dart';
import '../../modules/global_import.dart';
import '../constants/app_constants.dart';

class SharedState {
  // Map related
  static ValueNotifier<List<Marker>> visibleMarkers = ValueNotifier([]);
  static ValueNotifier<List<Marker>> cachedMarkers = ValueNotifier([]);
  static ValueNotifier<List<Marker>> landmarkMarkers = ValueNotifier([]);
  static ValueNotifier<List<Marker>> bikeMarkers = ValueNotifier([]);
  static ValueNotifier<Marker> userMarker = ValueNotifier(CustomMarker.user(latitude: 0, longitude: 0));
  static ValueNotifier<Marker> ridingMarker = ValueNotifier(CustomMarker.riding(latitude: 0, longitude: 0));
  static ValueNotifier<MapController> mapController = ValueNotifier(MapController());

  // General
  static ValueNotifier<bool> markerCardVisibility = ValueNotifier(false);
  static ValueNotifier<bool> isNavigating = ValueNotifier(false);
  static ValueNotifier<bool> isRiding = ValueNotifier(false);
  static ValueNotifier<MarkerCardContent> markerCardContent = ValueNotifier(MarkerCardContent.scanBike);

  // Bike related
  static ValueNotifier<String> bikeId = ValueNotifier("#999");
  static ValueNotifier<String> bikeStatus = ValueNotifier("Available");
  static ValueNotifier<double> bikeCurrentLatitude = ValueNotifier(double.minPositive);
  static ValueNotifier<double> bikeCurrentLongitude = ValueNotifier(double.minPositive);

  // Ride related
  static ValueNotifier<Timer?> timer = ValueNotifier<Timer?>(null);
  static ValueNotifier<String> currentTotalDistance = ValueNotifier("< 1 meter"); // In km/m format
  static ValueNotifier<String> currentRideTime = ValueNotifier("< 1 minute");  // In "xh xm" format
  static ValueNotifier<String> rideStartDatetime = ValueNotifier("1999-12-31 00:00:00"); // In DATETIME format
  static ValueNotifier<String> rideEndDatetime = ValueNotifier("1999-12-31 00:00:00"); // In DATETIME format

  // Landmark related
  static ValueNotifier<String> landmarkNameMalay = ValueNotifier("Fakulti Lorem Ipsum dan Technology Maklumat (FLITM)");
  static ValueNotifier<String> landmarkNameEnglish = ValueNotifier("Faculty of Lorem Ipsum and Information Teknologi");
  static ValueNotifier<String> landmarkType = ValueNotifier("Faculty");
  static ValueNotifier<String> landmarkAddress = ValueNotifier("Fakulti Lorem Ipsum dan Technology Maklumat (FLITM), Durian Tunggal 12345");
  static ValueNotifier<double> landmarkLatitude = ValueNotifier(double.minPositive);
  static ValueNotifier<double> landmarkLongitude = ValueNotifier(double.minPositive);

}