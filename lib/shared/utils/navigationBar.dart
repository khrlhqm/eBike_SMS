import 'package:flutter/material.dart';
import 'package:ebikesms/shared/widget/BottomNavBarItem.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';

class BottomNavSmoothTransitionApp extends StatelessWidget {
  final int userId; // Add userId

  const BottomNavSmoothTransitionApp({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavWithFloatingBar(
        userId: userId, // Pass userId to the next screen
      ),
    );
  }
}

class BottomNavWithFloatingBar extends StatefulWidget {
  final int userId; // Add userId

  const BottomNavWithFloatingBar({
    super.key,
    required this.userId,
  });

  @override
  _BottomNavWithFloatingBarState createState() =>
      _BottomNavWithFloatingBarState();
}

class _BottomNavWithFloatingBarState extends State<BottomNavWithFloatingBar> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    if (index != 1) {
      setState(() {
        _selectedIndex = index;
      });
      _pageController.jumpToPage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Welcome, ${widget.fullName}'), // Display full name
      ),
      body: Center(
        child: BottomNavChildrenWidget().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: ColorConstant.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: const [
                BoxShadow(
                  color: ColorConstant.black,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                items: bottomNavigationBarItems(),
                currentIndex: _selectedIndex,
                selectedItemColor: ColorConstant.darkBlue,
                unselectedItemColor: ColorConstant.black,
                onTap: _onItemTapped,
                showUnselectedLabels: true,
              ),
            ),
          ),
          Positioned(
            bottom: 25.0, // Position above the BottomNavigationBar
            child: FloatingActionButton(
              backgroundColor: ColorConstant.darkBlue,
              onPressed: () {
                // Handle Scan button press
              },
              elevation: 4.0,
              child: const Icon(Icons.qr_code_2_rounded,
                  color: ColorConstant.white),
            ),
          ),
        ],
      ),
    );
  }
}
