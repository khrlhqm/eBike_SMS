import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Secure storage dependency
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ebikesms/ip.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:ebikesms/shared/utils/custom_icon.dart';
import 'package:ebikesms/shared/widget/rectangle_button.dart';
import 'package:ebikesms/modules/menu/widget/icon_card.dart';
import 'package:ebikesms/modules/menu/widget/menu_strip_item.dart';
import 'package:ebikesms/modules/menu/sub-menu/time_top_up/screen/time_top_up.dart';
import 'package:ebikesms/modules/menu/sub-menu/ride_history/screen/ride_history.dart';
import 'package:ebikesms/modules/menu/sub-menu/settings/screen/settings.dart';
import 'package:ebikesms/modules/learn/screen/learn.dart';
import 'package:ebikesms/modules/menu/sub-menu/logout_modal.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Map<String, dynamic>? _userData;

  late String totalRideTime = ""; // TODO: Fetch from database

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      // Retrieve the user ID from secure storage
      String? userId = await _secureStorage.read(key: 'userId');

      if (userId != null) {
        // Fetch user data from the API using the user_id
        final response = await http.get(
          Uri.parse('${ApiBase.baseUrl}/get_user.php?user_id=$userId'),
        );

        if (response.statusCode == 200) {
          // Parse the user data
          final responseBody = json.decode(response.body);

          if (responseBody['status'] == 'success') {
            // Set the user data
            setState(() {
              _userData = responseBody['data'];  // Assuming the user data is in 'data' key
            });
          } else {
            throw Exception('Failed to fetch user data: ${responseBody['message']}');
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

  @override
  Widget build(BuildContext context) {
    // Make sure _userData is available before building the UI
    // if (_userData == null) {
    //   return const Scaffold(
    //     backgroundColor: Colors.white,
    //     body: const Center(child: CircularProgressIndicator()),
    //   );
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              children: [
                // Profile Section
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: ColorConstant.red,
                      child: CustomIcon.userColoured(40),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userData?['full_name'] ?? 'Loading...',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _userData?['matric_number'] ?? 'Loading...',
                          style: const TextStyle(color: ColorConstant.grey),
                        ),
                        Text(
                          _userData?['phone'] ?? 'Loading...',
                          style: const TextStyle(color: ColorConstant.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Ride Time Available Section
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: ColorConstant.darkBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomIcon.clock(20, color: ColorConstant.white),
                          const SizedBox(width: 10),
                          const Text(
                              'Ride Time Available',
                              style: TextStyle(color: ColorConstant.white, fontSize: 14)
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
                            child: Text(
                              (totalRideTime.isEmpty) ? "Empty Balance" : totalRideTime,
                              style: TextStyle(
                                color: ColorConstant.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontStyle: (totalRideTime.isEmpty) ? FontStyle.italic : FontStyle.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(color: ColorConstant.shadow, blurRadius: 5.5, offset: Offset(0, 3))
                                ]),
                            child: RectangleButton(
                                label: "Add time",
                                backgroundColor: ColorConstant.white,
                                foregroundColor: ColorConstant.black,
                                height: 35.0,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                borderRadius: 10,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const TimeTopUpScreen())
                                  );
                                }
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Ride History & Learn Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: IconCard(
                        iconWidget: CustomIcon.cycling(50, color: ColorConstant.black),
                        label: 'Ride history',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RideHistoryScreen()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: IconCard(
                        iconWidget: CustomIcon.learnColoured(50),
                        label: 'Learn how to use',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LearnScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )
          ),
          Column(
            children: [
              StripMenuItem(
                  iconWidget: CustomIcon.settings(24, color: ColorConstant.black),
                  label: "Settings",
                  textColor: ColorConstant.black,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                  }
              ),
              StripMenuItem(
                  iconWidget: CustomIcon.logout(24, color: ColorConstant.red),
                  label: "Log out",
                  textColor: ColorConstant.red,
                  onTap: () { logoutModal(context); }
              ),
            ]
          ),
        ],
      ),
    );
  }
}