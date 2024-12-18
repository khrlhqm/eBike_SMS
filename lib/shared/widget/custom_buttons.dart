import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../utils/custom_icon.dart';


class CustomBackButton extends StatelessWidget {
  final Color? buttonColor;
  final double? iconSize;

  const CustomBackButton({
    super.key,
    this.buttonColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: iconSize ?? 30.0, // Default icon size if not provided
        color: buttonColor ?? Colors.black, // Default color if not provided
      ),
      onPressed: () {
        Navigator.pop(context); // Navigate back
      },
    );
  }
}


class CustomCircularBackButton extends StatelessWidget {
  final double? buttonSize;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? iconColor;

  const CustomCircularBackButton({
    super.key,
    this.buttonSize,
    this.backgroundColor,
    this.shadowColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () { Navigator.pop(context); },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: EdgeInsets.zero,
        backgroundColor: backgroundColor ?? ColorConstant.white, // Background color
        shadowColor: shadowColor ?? ColorConstant.lightGrey, // Box shadow color
        elevation: 3,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomIcon.back(buttonSize ?? 30, color: iconColor ?? ColorConstant.black),
      ),
    );
  }
}


class CustomRectangleButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool enable;
  final Color backgroundColor;
  final Color foregroundColor;
  final double width;
  final double height;
  final double fontSize;
  final double borderRadius;
  final FontWeight fontWeight;
  final BorderSide borderSide;

  const CustomRectangleButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enable = true,
    // These default values are for long bottom buttons, above a white background color (Can be found in payment_amound.dart)
    this.backgroundColor = ColorConstant.darkBlue,
    this.foregroundColor = ColorConstant.white,
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 8,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.borderSide = BorderSide.none
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: enable ? onPressed : null,  // Editable, Disable onPressed if enable is false
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor, // Editable
            foregroundColor: foregroundColor, // Editable
            disabledBackgroundColor: ColorConstant.lightGrey,
            disabledForegroundColor: ColorConstant.grey,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
            minimumSize: const Size(double.infinity, 50),
            side: borderSide
        ),
        child: Text(
          label, // Editable
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight), // Editable
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

