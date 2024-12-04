import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Secure storage dependency
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ebikesms/ip.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:ebikesms/shared/utils/custom_icon.dart';
import 'package:ebikesms/modules/menu/sub-menu/ride_history/widget/history_strip_item.dart';
import 'package:ebikesms/modules/menu/screen/menu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ebikesms/modules/menu/widget/icon_card.dart';
import 'package:ebikesms/shared/widget/loading_animation.dart';

class RideHistoryScreen extends StatefulWidget {
  const RideHistoryScreen({Key? key}) : super(key: key);

  @override
  _RideHistoryScreenState createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  List<dynamic>? _userData;

  int totalTrips = 0;
  double totalDistance = 0;
  Duration totalRideTime = Duration();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Function to get the user_id
  Future<void> _fetchUserData() async {
    try {
      // Retrieve the user ID from secure storage
      String? userId = await _secureStorage.read(key: 'userId');

      if (userId != null) {
        // Fetch user data from the API using the user_id
        final response = await http.get(
          Uri.parse('${ApiBase.baseUrl}/get_ride_history.php?user_id=$userId'),
        );

        if (response.statusCode == 200) {
          // Parse the response body
          final responseBody = json.decode(response.body);

          if (responseBody['status'] == 'success') {
            // Set the user data as a list of rides
            setState(() {
              _userData =
                  List<dynamic>.from(responseBody['data']); // 'data' is a list
            });
            _calculateSummaryData(); // Calculate total trips, distance, and ride time
          } else {
            throw Exception(
                'Failed to fetch user data: ${responseBody['message']}');
          }
        } else {
          throw Exception('Failed to load user data');
        }
      } else {
        print("User ID not found in secure storage");
      }
    } catch (e) {
      // Handle errors (e.g., show a dialog or log)
      print('Error loading user data: $e');
    }
  }

  // Function to calculate total trips, distance, and ride time
  void _calculateSummaryData() {
    if (_userData != null) {
      totalTrips = _userData!.length; // Number of trips
      totalDistance = 0;
      totalRideTime = Duration();

      for (var ride in _userData!) {
        // Add the distance of each ride
        totalDistance += ride['distance'];

        // Calculate the ride time (start_time and end_time)
        DateTime start = DateTime.parse(ride['start_time']);
        DateTime end = DateTime.parse(ride['end_time']);
        totalRideTime += end.difference(start);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.darkBlue,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: CustomIcon.back(30),
        ),
        title: const Text(
          'Ride History',
          style: TextStyle(color: ColorConstant.white),
        ),
      ),
      body: Column(
        children: [
          // Summary section
          Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorConstant.shadow,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
              color: ColorConstant.lightBlue,
            ),
            child: Column(
              children: [
                const Text(
                  'Your journey with us',
                  style: TextStyle(color: ColorConstant.grey, fontSize: 14),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 10),
                  child: Text(
                    '$totalTrips trips completed', // Display dynamic total trips
                    style: const TextStyle(
                      color: ColorConstant.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIcon.clock(16, color: ColorConstant.black),
                    const SizedBox(width: 6),
                    Text(
                      '${totalDistance.toStringAsFixed(2)} km', // Display dynamic total distance
                      style: const TextStyle(color: ColorConstant.black),
                    ),
                    const SizedBox(width: 20),
                    CustomIcon.distance(16, color: ColorConstant.black),
                    const SizedBox(width: 6),
                    Text(
                      _formatDuration(
                          totalRideTime), // Display formatted total ride time
                      style: const TextStyle(color: ColorConstant.black),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // History strip items
          Expanded(
            child: _userData == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount:
                        _userData!.length, // Use the length of fetched data
                    itemBuilder: (context, index) {
                      var ride = _userData![index]; // Access each ride data
                      return HistoryStripItem(
                        bikeId: ride[
                            'bike_name'], // Use the 'bike_name' from API response
                        distance:
                            '${ride['distance']} km', // Format the distance
                        duration:
                            '${_calculateDuration(ride['start_time'], ride['end_time'])}', // Format duration
                        date: ride['start_time']
                            .split(' ')[0], // Extract date from the timestamp
                        time: ride['start_time']
                            .split(' ')[1], // Extract time from the timestamp
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Helper function to format ride duration (start_time and end_time)
  String _calculateDuration(String startTime, String endTime) {
    DateTime start = DateTime.parse(startTime);
    DateTime end = DateTime.parse(endTime);
    Duration diff = end.difference(start);
    return '${diff.inMinutes} min'; // Return the duration in minutes
  }

  // Helper function to format total ride time as a string
  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    return '${hours}h ${minutes}m'; // Format as 'Xh Xm'
  }
}