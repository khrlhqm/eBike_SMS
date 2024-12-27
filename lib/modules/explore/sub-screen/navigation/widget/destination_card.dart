import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {
  final String landmarkNameMalay;
  final String landmarkNameEnglish;
  final String landmarkType;
  final VoidCallback onPressed;
  const DestinationCard({
    super.key,
    required this.landmarkNameMalay,
    required this.landmarkNameEnglish,
    required this.landmarkType,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(25),
          backgroundColor: ColorConstant.lightBlue, // Set the background color
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                landmarkNameMalay,
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.black,
                ),
              )
            ),
            Text(
              landmarkType,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: ColorConstant.black
              ),
            )
          ],
        ),
      );
  }
}
