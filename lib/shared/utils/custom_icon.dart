import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcon{
  static Widget back(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/back.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget bicycle(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/bicycle.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget clock(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/clock.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget close(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/close.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget cycling(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/cycling.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget facefinder(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/facefinder.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget flashlight(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/flashlight.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget location(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/location.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget locationCurrent(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/location-current.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget logout(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/logout.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget menu(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/menu-staggered.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget minimize(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/minimize.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget search(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/search.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget settings(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/settings.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget distance(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/distance.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget warning(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/warning.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget downArrow(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/down-arrow.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  static Widget qrScanner(
    double dimension,
      {Color color = Colors.white}
  ) {
    return SvgPicture.asset(
      'assets/icons/qr-scanner.svg',
      width: dimension,
      height: dimension,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
    );
  }

  // Coloured
  static Widget checkedColoured(
    double dimension,
  ) {
    return SvgPicture.asset(
      'assets/icons/checked-coloured.svg',
      width: dimension,
      height: dimension,
    );
  }

  static Widget crosshairColoured(
    double dimension,
  ) {
    return SvgPicture.asset(
      'assets/icons/crosshair-coloured.svg',
      width: dimension,
      height: dimension,
    );
  }

  static Widget learnColoured(
    double dimension,
  ) {
    return SvgPicture.asset(
      'assets/icons/learn-coloured.svg',
      width: dimension,
      height: dimension,
    );
  }

  static Widget userColoured(
    double dimension,
  ) {
    return SvgPicture.asset(
      'assets/icons/user-coloured.svg',
      width: dimension,
      height: dimension,
    );
  }
}