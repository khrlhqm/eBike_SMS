import 'package:flutter/material.dart';
import 'package:ebikesms/modules/menu/learn/screen/learn.dart';
import 'package:ebikesms/modules/menu/rideHistory/screen/history.dart';
import 'package:ebikesms/modules/menu/settings/screen/setting.dart';
import 'package:ebikesms/modules/menu/widget/iconCard.dart';
import 'package:ebikesms/modules/menu/widget/modal.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Add secure storage dependency
import 'package:http/http.dart' as http;
import 'dart:convert';

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
          Uri.parse('http://192.168.0.25/e-bike/get_user.php?user_id=$userId'),
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
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: ColorConstant.red,
                  child: Icon(Icons.person, color: ColorConstant.white, size: 40),
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
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: ColorConstant.lightBlue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.access_time, color: ColorConstant.white),
                      SizedBox(width: 8),
                      Text(
                        'Ride Time Available',
                        style: TextStyle(color: ColorConstant.white, fontSize: 16),
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
                      ),
                    ),
                    child: const Text('Add more'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Ride History and Learn How to Use Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
              ),
              onTap: () {
                logoutModal(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}