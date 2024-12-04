import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  final Color? buttonColor;
  final double? iconSize;

  const BackButtonWidget({
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
