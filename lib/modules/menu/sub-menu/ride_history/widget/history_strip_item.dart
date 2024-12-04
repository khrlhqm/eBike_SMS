import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:ebikesms/shared/utils/custom_icon.dart';
import 'package:flutter/material.dart';

class HistoryStripItem extends StatelessWidget {
  final String bikeId;
  final String distance;
  final String duration;
  final String date;
  final String time;

  const HistoryStripItem({
    super.key,
    required this.bikeId,
    required this.distance,
    required this.duration,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: ColorConstant.lightGrey))
      ),
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListTile(
          leading: CustomIcon.bicycle(50, color: ColorConstant.black),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bike ID',
                style: TextStyle(fontSize: 12, color: ColorConstant.grey),
              ),
              Text(
                bikeId,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                distance,
                style: const TextStyle(fontSize: 12, color: ColorConstant.black),
              ),
              Text(
                duration,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.darkBlue,
                ),
              ),
              Text(
                '$date   $time',
                style: const TextStyle(fontSize: 10, color: ColorConstant.grey),
              ),
            ],
          ),
        ),
      )
    );
  }
}
