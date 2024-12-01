import 'package:flutter/material.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:ebikesms/modules/menu/sub-menu/ride_history/widget/history_card.dart';
import 'package:ebikesms/modules/menu/screen/menu.dart';
import 'package:flutter_svg/svg.dart';

class RideHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ride History',
          style: TextStyle(color: ColorConstant.white),
        ),
        backgroundColor: ColorConstant.darkBlue,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MenuApp(),
              ),
            );
          },
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            width: 24,
            height: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          // Top section with summary
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue.shade100,
            child: Column(
              children: [
                Text(
                  'Your journey with us',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 4.0),
                const Text(
                  '5 trips completed',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4.0),
                    Text(
                      '10 hours 20 mins',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 16.0),
                    Icon(Icons.directions_bike,
                        size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4.0),
                    Text(
                      '5.2 km (5269 m)',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Divider line
          Divider(height: 1, color: Colors.grey[300]),

          // List of rides
          Expanded(
            child: ListView.builder(
              itemCount: 3, // number of trips
              itemBuilder: (context, index) {
                return RideHistoryCard(
                  bikeId: '888432',
                  distance: index == 0
                      ? '0 m'
                      : index == 1
                          ? '2.5 km'
                          : '605 m',
                  duration: index == 0
                      ? '1 min'
                      : index == 1
                          ? '1 hour 54 mins'
                          : '33 mins',
                  date: '30 Nov 2024',
                  time: '15:12',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
