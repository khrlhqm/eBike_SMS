import 'package:ebikesms/modules/menu/learn/screen/learn.dart';
import 'package:ebikesms/modules/menu/rideHistory/screen/history.dart';
import 'package:ebikesms/modules/menu/settings/screen/setting.dart';
import 'package:flutter/material.dart';
import 'package:ebikesms/modules/menu/widget/iconCard.dart';
import 'package:ebikesms/modules/menu/widget/modal.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:flutter_svg/svg.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: ColorConstant.red,
                  child:
                      Icon(Icons.person, color: ColorConstant.white, size: 40),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Muhammad Lorem Ipsum',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'B033300099',
                      style: TextStyle(color: ColorConstant.grey),
                    ),
                    Text(
                      '+60 ',
                      style: TextStyle(color: ColorConstant.grey),
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
                        style:
                            TextStyle(color: ColorConstant.white, fontSize: 16),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RideHistoryPage(),
                      ),
                    );
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
            //const Spacer(),

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
