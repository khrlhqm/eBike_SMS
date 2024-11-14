import 'package:flutter/material.dart';
import 'package:ebikesms/shared/widget/BottomNavBarItem.dart';

class BottomNavSmoothTransitionApp extends StatelessWidget {
  const BottomNavSmoothTransitionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavWithFloatingBar(),
    );
  }
}

class BottomNavWithFloatingBar extends StatefulWidget {
  const BottomNavWithFloatingBar({super.key});

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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: PageView(
  //       controller: _pageController,
  //       onPageChanged: (index) {
  //         if (index != 2) {
  //           setState(() {
  //             _selectedIndex = index;
  //           });
  //         }
  //       },
  //       children: BottomNavChildrenWidget(),
  //     ),
  // bottomNavigationBar: Stack(
  //   alignment: AlignmentDirectional.topCenter,
  //   children: [
  //     Container(
  //       padding:
  //           const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
  //       margin: const EdgeInsets.only(bottom: 20.0),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(30.0),
  //         boxShadow: const [
  //           BoxShadow(
  //             color: Colors.black12,
  //             blurRadius: 10.0,
  //             spreadRadius: 2.0,
  //             offset: Offset(0, 5),
  //           ),
  //         ],
  //       ),
  //       child: BottomNavigationBar(
  //         backgroundColor: Colors.transparent,
  //         elevation: 0,
  //         items: bottomNavigationBarItems(),
  //         currentIndex: _selectedIndex,
  //         selectedItemColor: const Color.fromARGB(255, 0, 51, 153),
  //         unselectedItemColor: Colors.black,
  //         onTap: _onItemTapped,
  //         showUnselectedLabels: true,
  //       ),
  //     ),
  //     Positioned(
  //       bottom: 30.0,
  //       child: FloatingActionButton(
  //         backgroundColor: Colors.blue,
  //         onPressed: () {
  //           // Handle Scan button press
  //         },
  //         elevation: 4.0,
  //         child: const Icon(Icons.qr_code_2_rounded, color: Colors.white),
  //       ),
  //     ),
  //   ],
  // ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BottomNavChildrenWidget().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
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
                selectedItemColor: const Color.fromARGB(255, 0, 51, 153),
                unselectedItemColor: Colors.black,
                onTap: _onItemTapped,
                showUnselectedLabels: true,
              ),
            ),
          ),
          Positioned(
            bottom: 25.0, // Position above the BottomNavigationBar
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                // Handle Scan button press
              },
              elevation: 4.0,
              child: const Icon(Icons.qr_code_2_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
