import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class RectangleButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool enable;

  const RectangleButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55.0,
      child: TextButton(
        onPressed: enable ? onPressed : null,  // Disable onPressed if enable is false
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstant.darkBlue, // Normal background color
          foregroundColor: ColorConstant.white, // Normal text color
          disabledBackgroundColor: ColorConstant.lightGrey, // Background color when disabled
          disabledForegroundColor: ColorConstant.grey, // Text color when disabled
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 15),
          minimumSize: const Size(double.infinity, 55),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
