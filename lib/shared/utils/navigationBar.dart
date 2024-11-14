import 'package:flutter/material.dart';
import 'package:ebikesms/modules/profile/screen/profile.dart';
import 'package:ebikesms/modules/dashboard/screen/dashboard.dart';
import 'package:ebikesms/modules/location/screen/location.dart';

/// Flutter code sample for [BottomNavigationBar].

class BottomNavSmoothTransitionApp extends StatelessWidget {
  const BottomNavSmoothTransitionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavWithPageView(),
    );
  }
}

class BottomNavWithPageView extends StatefulWidget {
  const BottomNavWithPageView({super.key});

  @override
  _BottomNavWithPageViewState createState() => _BottomNavWithPageViewState();
}

class _BottomNavWithPageViewState extends State<BottomNavWithPageView> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const <Widget>[
          Dashboard(),
          Location(),
          AnalyticsTab(),
          Profile(),
        ],
      ),
      bottomNavigationBar: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: 'Located',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_2_rounded),
                label: 'Qr Code',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart), label: 'Statictic'),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Menu',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 0, 51, 153),
            unselectedItemColor: Colors.black,
            onTap: _onItemTapped,
            showUnselectedLabels: true,
          ),
          Positioned(
            top: -20.0,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                // Handle Scan QR button press
              },
              child: const Icon(Icons.qr_code_2_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class AnalyticsTab extends StatelessWidget {
  const AnalyticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Analytics Content',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
