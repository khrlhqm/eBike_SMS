import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class RectangleButton extends StatelessWidget {
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

  const RectangleButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enable = true,
    // These default values are for long bottom buttons, above a white background color (Can be found in payment_amound.dart)
    this.backgroundColor = ColorConstant.darkBlue,
    this.foregroundColor = ColorConstant.white,
    this.width = double.infinity,
    this.height = 55.0,
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
