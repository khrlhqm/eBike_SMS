import 'package:ebikesms/shared/widget/marker_card.dart';
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
      return _BottomNavBarRider();  // If it's 'rider', show rider state
    }
    else { // If it's 'admin', show admin state
      return _BottomNavBarAdmin();
    }
  }
}


// User type: Rider
// User type: Rider
// User type: Rider
class _BottomNavBarRider extends State<BottomNavBar> {
  late final PageController _pageController = PageController();
  late double _labelSize;
  late double _navBarWidth;
  late double _navBarHeight;
  late bool _isMarkerCardVisible;
  late bool _isNavigating;
  late MarkerCardState _markerCardState;
  int _selectedNavIndex = 0;

  late String bikeStatus = "Available";
  late String bikeId = "#999";
  late String currentTotalDistance = "999 km";
  late String currentRideTime = "999 mins";

  late String locationNameMalay = "Fakulti Belum Dapat dan Technology Maklumat (FBDTM)";
  late String locationNameEnglish = "Faculty of Have Not Completed and Information Teknologi";
  late String locationType = "Faculty";
  late String address = "Block A, Jalan Belum Buat, 54100 California, Malaysia";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navBarHeight = 60;
    _labelSize = 11;
    _isMarkerCardVisible = true; // Alter this to get marker types
    _isNavigating = false; // Alter this to get marker types
    _markerCardState = MarkerCardState.location; // Alter this variable to get marker types
  }

  @override
  Widget build(BuildContext context) {
    // _navBarWidth is placed here due to "MediaQuery" requires build context to get screen width
    _navBarWidth = MediaQuery.of(context).size.width * 0.7;
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            bottomNavChildrenWidget().elementAt(_selectedNavIndex),
            Visibility(
              visible: _isMarkerCardVisible,
              child: MarkerCard(
                markerCardState: _markerCardState,
                isNavigating: _isNavigating,
                // Bike marker cards:
                bikeStatus: bikeStatus,
                bikeId: bikeId,
                currentTotalDistance: currentTotalDistance,
                currentRideTime: currentRideTime,
                // Location marker cards:
                locationNameMalay: locationNameMalay,
                locationNameEnglish: locationNameEnglish,
                locationType: locationType,
                address: address,
              )
            ),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              fit: StackFit.passthrough,
              children: [
                Container(
                  height: _navBarHeight,
                  width: _navBarWidth,
                  constraints: BoxConstraints(
                    maxWidth: _navBarWidth,
                    minWidth: 200,
                  ),
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
                      selectedLabelStyle: TextStyle(fontSize: _labelSize, fontWeight: FontWeight.w600),
                      unselectedItemColor: ColorConstant.black,
                      unselectedLabelStyle: TextStyle(fontSize: _labelSize, fontWeight: FontWeight.normal),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        // Handle Scan button press
                      },
                      child: Builder(
                        builder: (context) {
                          switch(_markerCardState) {
                            case MarkerCardState.ridingBike:
                              return Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: ColorConstant.red,
                                      width: 3,
                                    ),
                                  ),
                                  child: CustomIcon.close(24, color: ColorConstant.red)
                              );
                            case MarkerCardState.warningBike:
                              return Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: const BoxDecoration(
                                    color: ColorConstant.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CustomIcon.warning(28, color: ColorConstant.white)
                              );
                            default:
                              return Container(
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                  color: ColorConstant.darkBlue,
                                  shape: BoxShape.circle,
                                ),
                                child: CustomIcon.qrScanner(28, color: ColorConstant.white)
                            );
                          }
                        },
                      )
                    ),
                    const SizedBox(height: 3),
                    SizedBox(
                      width: 120,
                      child: Builder(
                        builder: (context) {
                          switch(_markerCardState) {
                            case MarkerCardState.warningBike:
                              return SizedBox(height: _labelSize + 4);
                            case MarkerCardState.ridingBike:
                              return Text(
                                "End ride",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: _labelSize, color: ColorConstant.red, fontWeight: FontWeight.bold),
                              );
                            default:
                              return Text(
                                "Scan",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: _labelSize),
                              );
                          }
                        },
                      )
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
            child: CustomIcon.menu(23, color: ColorConstant.black)
        ),
        activeIcon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: CustomIcon.menu(23, color: ColorConstant.darkBlue)
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
}


// User type: Admin
// User type: Admin
// User type: Admin
class _BottomNavBarAdmin extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
