import 'package:flutter/material.dart';
import '../utils/custom_color.dart';

class RectangleButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const RectangleButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 55.0,
        child: TextButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColor.darkBlue,
            foregroundColor: CustomColor.white,
            disabledBackgroundColor: CustomColor.lightGrey,
            disabledForegroundColor: CustomColor.grey,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 15), // Adjust padding here
            minimumSize: const Size(double.infinity, 55), // Ensures full-width button with fixed height
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
    )
    );
  }
}
