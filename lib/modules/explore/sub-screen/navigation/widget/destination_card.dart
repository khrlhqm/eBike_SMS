import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {
  final String locationNameMalay;
  final String locationNameEnglish;
  final String locationType;
  //final String onPressed;
  const DestinationCard({
    super.key,
    required this.locationNameMalay,
    required this.locationNameEnglish,
    required this.locationType,
    //required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(25),
          backgroundColor: ColorConstant.lightBlue, // Set the background color
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        ),
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                locationNameMalay,
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
              locationType,
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
