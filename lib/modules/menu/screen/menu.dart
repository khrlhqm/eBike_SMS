import 'package:auto_size_text/auto_size_text.dart';
import 'package:ebikesms/modules/menu/widget/icon_card.dart';
import 'package:ebikesms/modules/menu/widget/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Secure storage dependency
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ebikesms/ip.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:ebikesms/shared/utils/custom_icon.dart';

import 'package:ebikesms/modules/menu/sub-menu/time_top_up/screen/time_top_up.dart';
import 'package:ebikesms/modules/menu/sub-menu/ride_history/screen/ride_history.dart';
import 'package:ebikesms/modules/menu/sub-menu/settings/screen/policy.dart';
import 'package:ebikesms/modules/menu/sub-menu/settings/screen/about.dart';
import 'package:ebikesms/modules/learn/screen/learn.dart';
import 'package:ebikesms/modules/menu/widget/logout_modal.dart';
import 'package:ebikesms/modules/menu/sub-menu/user_report/user_report.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  late String totalRideTime = ""; // TODO: Fetch from database
  Map<String, dynamic>? _userData;

  final ValueNotifier<String> _totalRideTime = ValueNotifier<String>('');
  bool _settingsExpanded = false; // Manage dropdown state

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    _totalRideTime.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    try {
      // Retrieve the user ID from secure storage
      String? userId = await _secureStorage.read(key: 'userId');

      if (userId != null) {
        // Fetch user data from the API using the user_id
        final response = await http.get(
          Uri.parse('${ApiBase.baseUrl}/get_user_id.php?user_id=$userId'),
        );

        if (response.statusCode == 200) {
          // Parse the user data
          final responseBody = json.decode(response.body);

          if (responseBody['status'] == 'success') {
            // Set the user data
            setState(() {
              _userData = responseBody['data'];
            });
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
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.hintBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
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
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _userData?['matric_number'] ?? 'Loading...',
                      style: const TextStyle(color: ColorConstant.grey),
                    ),
                    Text(
                      _userData?['phone_number'] ?? '+06 ...',
                      style: const TextStyle(color: ColorConstant.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Available Ride Time Section
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Bottom larger box
                  Container(
                    width: double.infinity,
                    height: 185,
                    decoration: BoxDecoration(
                      color: ColorConstant.shadowdarkBlue, // Darker blue color
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  // Positioned Button ("+ Add More")
                  Positioned(
                    top: 135,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TimeTopUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "+ Add More",
                          style: TextStyle(
                            color: ColorConstant.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Positioned Button ("+ Add More")
                  Positioned(
                    top: 135,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TimeTopUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "+ Add More",
                          style: TextStyle(
                            color: ColorConstant.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Top card with ride time information
                  Positioned(
                    top: -10,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 145,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: ColorConstant.darkBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Ride Time Header
                          Row(
                            children: [
                              CustomIcon.clock(20, color: ColorConstant.white),
                              const SizedBox(width: 10),
                              const Text(
                                'AVAILABLE RIDE TIME',
                                style: TextStyle(
                                  color: ColorConstant.white,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 1.0,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Ride Time Value
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: AutoSizeText(
                              _userData?['obtained_ride_time'] ??
                                  'Empty Balance.', // Use the phone number or default value
                              maxFontSize: 28,
                              minFontSize: 24,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.white,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: IconCard(
                    iconWidget:
                        CustomIcon.bicycle(50, color: ColorConstant.black),
                    iconWidget:
                        CustomIcon.bicycle(50, color: ColorConstant.black),
                    label: 'Ride History',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RideHistoryScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10), // Add spacing between cards
                Expanded(
                  child: IconCard(
                    iconWidget: CustomIcon.learnColoured(50),
                    label: 'Learn how to use',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LearnScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ExpansionTile(
                  leading:
                      CustomIcon.settings(24, color: ColorConstant.darkBlue),
                  title: const Text(
                    "Settings",
                    style: TextStyle(
                      color: ColorConstant.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  trailing: Icon(
                    _settingsExpanded
                        ? Icons.expand_more
                        : Icons.arrow_forward_ios,
                    color: ColorConstant.darkBlue,
                    size: 20.0, // Set a consistent size for both icons
                  ),
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _settingsExpanded = expanded;
                    });
                  },
                  children: [
                    // ListTile(
                    //   title: const Text(
                    //     "Account",
                    //     style: TextStyle(
                    //       color: ColorConstant.grey,
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const AccountSettingsScreen(),
                    //       ),
                    //     );
                    //   },
                    // ),
                    ListTile(
                      title: const Text(
                        "Policy",
                        style: TextStyle(
                          color: ColorConstant.grey,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PolicyScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "About",
                        style: TextStyle(
                          color: ColorConstant.grey,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                ListTile(
                  leading: CustomIcon.logout(24, color: ColorConstant.darkBlue),
                  title: const Text(
                    "Logout",
                    style: TextStyle(
                        color: ColorConstant.black, fontFamily: 'Poppins'),
                  ),
                  onTap: () {
                    logoutModal(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
