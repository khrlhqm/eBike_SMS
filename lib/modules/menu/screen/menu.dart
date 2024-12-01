<<<<<<< Updated upstream
import 'package:flutter/material.dart';
import 'package:ebikesms/modules/menu/learn/screen/learn.dart';
import 'package:ebikesms/modules/menu/rideHistory/screen/history.dart';
import 'package:ebikesms/modules/menu/settings/screen/setting.dart';
import 'package:ebikesms/modules/menu/widget/iconCard.dart';
=======
import 'package:ebikesms/modules/menu/sub-menu/time_top_up/screen/time_top_up.dart';
import 'package:ebikesms/modules/menu/sub-menu/ride_history/screen/ride_history.dart';
import 'package:ebikesms/modules/learn/screen/learn.dart';
import 'package:ebikesms/modules/menu/sub-menu/settings/screen/setting.dart';
import 'package:flutter/material.dart';
import 'package:ebikesms/modules/menu/widget/icon_card.dart';
>>>>>>> Stashed changes
import 'package:ebikesms/modules/menu/widget/modal.dart';
import 'package:ebikesms/modules/menu/widget/strip_menu_item.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';
<<<<<<< Updated upstream
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Add secure storage dependency
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ebikesms/ip.dart';

=======
import 'package:ebikesms/shared/utils/custom_icon.dart';
import 'package:ebikesms/shared/widget/rectangle_button.dart';
>>>>>>> Stashed changes

class MenuApp extends StatelessWidget {
  const MenuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}


class _MenuScreenState extends State<MenuScreen> {
<<<<<<< Updated upstream
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Map<String, dynamic>? _userData;

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
=======
  late String name = "Muhammad Lorem Ipsum";
  late String matricNumber = "B033300099";
  late String phoneNumber = "+60 1777777";
  late String totalRideTime = "";
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    // Make sure _userData is available before building the UI
    if (_userData == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Profile Section
            Row(
              children: [
<<<<<<< Updated upstream
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: ColorConstant.red,
                  child: Icon(Icons.person, color: ColorConstant.white, size: 40),
=======
                CircleAvatar(
                  radius: 35,
                  backgroundColor: ColorConstant.red,
                  child: CustomIcon.userColoured(40)
                      //Icon(Icons.person, color: ColorConstant.white, size: 40),
>>>>>>> Stashed changes
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
<<<<<<< Updated upstream
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
=======
                      name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      matricNumber,
                      style: TextStyle(color: ColorConstant.grey),
                    ),
                    Text(
                      phoneNumber,
                      style: TextStyle(color: ColorConstant.grey),
>>>>>>> Stashed changes
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Ride Time Available Section
            Container(
              padding: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: ColorConstant.lightBlue,
                borderRadius: BorderRadius.circular(16),
                color: ColorConstant.darkBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time, color: ColorConstant.white),
                      CustomIcon.clock(20, color: ColorConstant.white),
                      SizedBox(width: 8),
                      Text(
                      const Text(
                        'Ride Time Available',
<<<<<<< Updated upstream
                        style: TextStyle(color: ColorConstant.white, fontSize: 16),
=======
                        style: TextStyle(color: ColorConstant.white, fontSize: 14),
>>>>>>> Stashed changes
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '2 hours 40 mins',
                    style: TextStyle(
                        color: ColorConstant.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Add more button action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.white,
                      foregroundColor: ColorConstant.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
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
                    ),
                    child: const Text('Add more'),
                      Container(
                        width: 120,
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.shadow,
                              blurRadius: 5.5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: RectangleButton(
                          label: "Add time",
                          backgroundColor: ColorConstant.white,
                          foregroundColor: ColorConstant.black,
                          height: 35.0,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          borderRadius: 10,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const TimeTopUpScreen()));
                          }
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Ride History and Learn How to Use Section
            // Ride History & Learn Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
<<<<<<< Updated upstream
                iconCard(
                  icon: Icons.directions_bike,
                  label: 'Ride history',
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const RideHistoryPage(),
                    //   ),
                    // );
                  },
=======
                Expanded(
                  child: IconCard(
                    iconWidget: CustomIcon.cycling(50, color: ColorConstant.black),
                    label: 'Ride history',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RideHistoryPage(),
                        ),
                      );
                    },
                  ),
>>>>>>> Stashed changes
                ),
                iconCard(
                  icon: Icons.lightbulb,
                  label: 'Learn how to use',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Learn(),
                      ),
                    );
                  },
                const SizedBox(width: 20),
                Expanded(
                  child: IconCard(
                    iconWidget: CustomIcon.learnColoured(50),
                    label: 'Learn how to use',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Learn(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/icons/settings.svg',
                  width: 24,
                  height: 24,
                  color: ColorConstant.black,
                ),
              ),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
            // List tiles below card buttons
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  StripMenuItem(
                    iconWidget: CustomIcon.settings(24, color: ColorConstant.black),
                    label: "Settings",
                    textColor: ColorConstant.black,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                    }
                  ),
                );
              },
            ),
            ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/icons/logout.svg',
                  width: 24,
                  height: 24,
                  color: ColorConstant.red,
                ),
              ),
              title: const Text(
                'Logout',
                style: TextStyle(color: ColorConstant.red),
                  StripMenuItem(
                    iconWidget: CustomIcon.logout(24, color: ColorConstant.red),
                    label: "Log out",
                    textColor: ColorConstant.red,
                    onTap: () { logoutModal(context); },
                  ),
                ],
              ),
              onTap: () {
                logoutModal(context);
              },
            ),
            )
          ],
        ),
      ),
    );
  }
}