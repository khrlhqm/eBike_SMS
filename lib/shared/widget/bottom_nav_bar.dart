import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../../modules/location/screen/location.dart';
import '../../modules/menu/screen/menu.dart';
import '../utils/custom_icon.dart';


class BottomNavBar extends StatefulWidget {
  final int userId;
  final String userType;

  const BottomNavBar({
    super.key,
    required this.userId,
    required this.userType, // TODO: userType
  });

  @override
  State<BottomNavBar> createState() {
    if(userType == 'Rider') {
      return _BottomNavBarRider();
    }
    else { // If it's 'admin'
      return _BottomNavBarAdmin();
    }
  }
}


class _BottomNavBarRider extends State<BottomNavBar> {
  final PageController _pageController = PageController();
  final double labelSize = 12;
  late double navBarWidth;
  int _selectedNavIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedNavIndex) {
      setState(() {
        _selectedNavIndex = index;
      });
      _pageController.jumpToPage(index);
    }
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        label: 'Explore',
        icon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: CustomIcon.location(22, color: ColorConstant.black)
        ),
        activeIcon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: CustomIcon.location(22, color: ColorConstant.darkBlue)
        ),
      ),
      const BottomNavigationBarItem(
        icon: SizedBox.shrink(),
        label: '',
      ),
      BottomNavigationBarItem(
        label: 'Menu',
        icon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: CustomIcon.menu(22, color: ColorConstant.black)
        ),
        activeIcon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: CustomIcon.menu(22, color: ColorConstant.darkBlue)
        ),
      ),
    ];
  }

  List<Widget> bottomNavChildrenWidget() {
    return [
      const Location(),
      const Center(child: Text("QR Code Dummy")),
      const MenuScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    navBarWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            bottomNavChildrenWidget().elementAt(_selectedNavIndex),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              fit: StackFit.passthrough,
              children: [
                Container(
                  height: 65,
                  width: navBarWidth,
                  margin: const EdgeInsets.only(bottom: 25),
                  decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(15.0), // To adjust the white box corner radius
                    boxShadow: const [
                      BoxShadow(color: ColorConstant.shadow, blurRadius: 4.0, offset: Offset(0, 2)),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0), // To adjust the touch animation corner radius
                    child: BottomNavigationBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      selectedItemColor: ColorConstant.darkBlue,
                      selectedLabelStyle: TextStyle(fontSize: labelSize, fontWeight: FontWeight.w600),
                      unselectedItemColor: ColorConstant.black,
                      unselectedLabelStyle: TextStyle(fontSize: labelSize, fontWeight: FontWeight.normal),
                      currentIndex: _selectedNavIndex,
                      showUnselectedLabels: true,
                      items: _bottomNavigationBarItems(),
                      onTap: _onItemTapped,
                    ),
                  )
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Handle Scan button press
                      },
                      child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            color: ColorConstant.darkBlue,
                            shape: BoxShape.circle,
                          ),
                          child: CustomIcon.qrScanner(30, color: ColorConstant.white)
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(
                        "Scan",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: labelSize),
                      ),
                    ),
                    const SizedBox(height: 34),
                  ],
                )
              ],
            ),
          ],
        )
      ),
    );
  }
}


class _BottomNavBarAdmin extends State<BottomNavBar> {
  final PageController _pageController = PageController();
  final double labelSize = 12;
  late double navBarWidth;
  int _selectedNavIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedNavIndex) {
      setState(() {
        _selectedNavIndex = index;
      });
      _pageController.jumpToPage(index);
    }
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        label: 'Explore',
        icon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: CustomIcon.location(22, color: ColorConstant.black)
        ),
        activeIcon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: CustomIcon.location(22, color: ColorConstant.darkBlue)
        ),
      ),
      BottomNavigationBarItem(
        label: 'Reports',
        icon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: CustomIcon.downArrow(22, color: ColorConstant.black)
        ),
        activeIcon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: CustomIcon.downArrow(22, color: ColorConstant.darkBlue)
        ),
      ),
      BottomNavigationBarItem(
        label: 'Menu',
        icon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: CustomIcon.menu(22, color: ColorConstant.black)
        ),
        activeIcon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: CustomIcon.menu(22, color: ColorConstant.darkBlue)
        ),
      ),
    ];
  }

  List<Widget> bottomNavChildrenWidget() {
    return [
      const Location(),
      const Center(child: Text("Incident reports is displayed here")),
      const Center(child: Text("Admin menu")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    navBarWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            bottomNavChildrenWidget().elementAt(_selectedNavIndex),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              fit: StackFit.passthrough,
              children: [
                Container(
                  height: 65,
                  width: navBarWidth,
                  margin: const EdgeInsets.only(bottom: 25),
                  decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(15.0), // To adjust the white box corner radius
                    boxShadow: const [
                      BoxShadow(color: ColorConstant.shadow, blurRadius: 4.0, offset: Offset(0, 2)),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0), // To adjust the touch animation corner radius
                    child: BottomNavigationBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      selectedItemColor: ColorConstant.darkBlue,
                      selectedLabelStyle: TextStyle(fontSize: labelSize, fontWeight: FontWeight.w600),
                      unselectedItemColor: ColorConstant.black,
                      unselectedLabelStyle: TextStyle(fontSize: labelSize, fontWeight: FontWeight.normal),
                      currentIndex: _selectedNavIndex,
                      showUnselectedLabels: true,
                      items: _bottomNavigationBarItems(),
                      onTap: _onItemTapped,
                    ),
                  )
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
