import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:ntp/ntp.dart';

class Calculation {
  static String countRideTimeFormatted(int amount) {
    int totalMinutes = amount ~/ PricingConstant.priceRate;
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;
    String rideTime = "";

    if(totalMinutes < 1) return "< 1 min";

    bool hasHour = hours > 0;
    if (hasHour) {
      rideTime += "$hours${hours == 1 ? ' hour' : ' hours'}";
    }

    if (minutes > 0) {
      rideTime += "${hasHour ? " $minutes${minutes == 1 ? ' minute' : ' minutes'}" : "$minutes${minutes == 1 ? ' minute' : ' minutes'}"} ";
    }

    return rideTime;
  }

  static int countRideTimeMinutes(int amount) {
    int totalMinutes = amount ~/ PricingConstant.priceRate;
    return totalMinutes;
  }


  // static String getCurrentDateTime() {
  //   return DateTime.now().toString().substring(0, 19);
  // }


  static Future<String> getCurrentDateTime() async {
    try {
      // Fetch NTP time
      DateTime ntpTime = await NTP.now();

      // Format DateTime to MySQL-compatible format (YYYY-MM-DD HH:mm:ss)
      String formattedTime = ntpTime.toUtc().toString().split('.')[0];

      return formattedTime;
    } catch (e) {
      debugPrint("Failed to fetch NTP time: $e");
      return "";
    }
  }

}