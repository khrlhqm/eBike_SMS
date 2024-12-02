import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:ebikesms/modules/menu/screen/menu.dart';
import 'package:ebikesms/modules/location/screen/location.dart';
import 'package:flutter_svg/svg.dart';

List<BottomNavigationBarItem> bottomNavigationBarItems() {
  return [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/icons/location.svg',
        width: 24,
        height: 24,
        color: ColorConstant.black,
      ),
      label: 'Location',
    ),
    const BottomNavigationBarItem(
      icon: SizedBox.shrink(),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/icons/menu-staggered.svg',
        width: 24,
        height: 24,
        color: ColorConstant.black,
      ),
      label: 'Menu',
    ),
  ];
}

List<Widget> BottomNavChildrenWidget() {
  return [
    const Location(),
    const Center(child: Text("QR Code Dummy")),
    const MenuScreen(),
  ];
}
