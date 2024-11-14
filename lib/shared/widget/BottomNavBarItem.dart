import 'package:flutter/material.dart';
import 'package:ebikesms/modules/profile/screen/profile.dart';
import 'package:ebikesms/modules/location/screen/location.dart';

List<BottomNavigationBarItem> bottomNavigationBarItems() {
  return [
    const BottomNavigationBarItem(
      icon: Icon(Icons.location_on),
      label: 'Location',
    ),
    const BottomNavigationBarItem(
      icon: SizedBox.shrink(),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      label: 'Menu',
    ),
  ];
}

List<Widget> BottomNavChildrenWidget() {
  return [
    const Location(),
    const Center(child: Text("QR Code Dummy")),
    const Profile(),
  ];
}
