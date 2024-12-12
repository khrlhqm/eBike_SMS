import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class TextConstant {
  static const String appName = "eBike Student Mobility Solutions";
  static const String greet = "Welcome to Unibike";
  static const String description =
      "located any bike nearby and scan the qr code.Enjoy your ride!";
  static const String description2 =
      "This is a tutorial on how to use the e-bike. Enjoy learning!";
  static const String priceRateLabel = "RM1/15 minutes";
  static const String minTopUpLabel = "RM10";
  static const String cyclingUrl = "cycling-regular";
}

class PricingConstant {
  static const int minTopUpAmt = 10;
  static const double priceRate = 1 / 15;
  static const int rideTimeLimit = 1800; // 30 Hours (1800 minutes)
}

class ColorConstant {
  static const Color darkBlue = Color(0xFF003399); // #003399
  static const Color shadowdarkBlue =
      Color.fromARGB(255, 0, 37, 112); // #003399
  static const Color lightBlue = Color(0xFFDBE6FF); // #DBE6FF
  static const Color hintBlue = Color(0xFFF2F6FF); // #F2F6FF
  static const Color grey = Color(0xFF4F4F4F); // #4F4F4F
  static const Color lightGrey = Color(0xFFD9D9D9); // #4F4F4F
  static const Color black = Color(0xFF1E1E1E); // #1E1E1E
  static const Color white = Color(0xFFFFFFFF); // #FFFFFF
  static const Color whitesmoke = Color(0xFF636363); // #636363
  static const Color red = Color(0xFFFF0400); // #FF0400
  static const Color yellow = Color(0xFFEED202); // #eed202
  static const Color shadow = Color(0x41000000); // #eed202
}

enum MarkerCardState {
  loading,
  scanBike,
  confirmBike,
  ridingBike,
  warningBike,
  location
}

class LocationConstant{
  static const LatLng initialCenter = LatLng(2.31125, 102.32025);
}