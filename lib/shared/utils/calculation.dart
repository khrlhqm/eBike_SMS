import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:ntp/ntp.dart';

class Calculation {

  // Converting the amount of money, to ride time format (x hours x minutes, or x minutes)
  static String convertMoneyToLongRideTime(int amount) {
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

  static String convertMinuteToShortRideTime(int totalMinutes) {
    if (totalMinutes < 1) return "< 1 min";

    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    if (hours == 0) {
      return "$minutes min${minutes > 1 ? 's' : ''}";
    } else if (minutes == 0) {
      return "${hours}h";
    } else {
      return "${hours}h ${minutes}m";
    }
  }

  // Converting the amount of money, to minute integers without format
  static int convertMoneyToMinutes(int amount) {
    int totalMinutes = amount ~/ PricingConstant.priceRate;
    return totalMinutes;
  }

  // Get current DATETIME from NTP (Network Time Protocol) service
  static Future<String> getCurrentDateTime() async {
    try {
      // Fetch NTP time
      DateTime ntpTime = await NTP.now();

      // Format DateTime to MySQL-compatible format (YYYY-MM-DD HH:mm:ss)
      String formattedTime = ntpTime.toUtc().toString().split('.')[0];

      return formattedTime;
    } catch (e) {
      debugPrint("Failed to fetch NTP datetime: $e");
      return "";
    }
  }

  // Converts value in meters into m or km
  static String convertToDistanceFormat(double meters) {
    if (meters >= 1000) {
      // Convert to kilometers if the distance is 1000 meters or more
      double kilometers = meters / 1000;
      return kilometers % 1 == 0
          ? '${kilometers.toInt()} km'
          : '${kilometers.toStringAsFixed(2)} km';
    } else {
      // If less than 1000 meters, keep it in meters
      return meters % 1 == 0
          ? '${meters.toInt()} m'
          : '${meters.toStringAsFixed(2)} m';
    }
  }

}