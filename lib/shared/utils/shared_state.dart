import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class SharedState {
  // TODO: Declare user login ValueNotifiers

  ValueNotifier<bool> markerCardVisibility = ValueNotifier(false);
  ValueNotifier<bool> navigationButtonEnable = ValueNotifier(true);
  ValueNotifier<MarkerCardState> markerCardState = ValueNotifier(MarkerCardState.scanBike);

  // Bike related
  ValueNotifier<String> bikeId = ValueNotifier("#999");
  ValueNotifier<String> bikeStatus = ValueNotifier("Available");
  ValueNotifier<double> bikeCurrentLatitude = ValueNotifier(double.minPositive);
  ValueNotifier<double> bikeCurrentLongitude = ValueNotifier(double.minPositive);

  // Ride related
  ValueNotifier<String> currentTotalDistance = ValueNotifier("999 km");
  ValueNotifier<String> currentRideTime = ValueNotifier("999 mins");

  // Location related
  ValueNotifier<String> locationNameMalay = ValueNotifier("Fakulti Lorem Ipsum dan Technology Maklumat (FLITM)");
  ValueNotifier<String> locationNameEnglish = ValueNotifier("Faculty of Lorem Ipsum and Information Teknologi");
  ValueNotifier<String> locationType = ValueNotifier("Faculty");
  ValueNotifier<String> address = ValueNotifier("Fakulti Lorem Ipsum dan Technology Maklumat (FLITM), Durian Tunggal 12345");
  ValueNotifier<double> locationLatitude = ValueNotifier(double.minPositive);
  ValueNotifier<double> locationLongitude = ValueNotifier(double.minPositive);

}