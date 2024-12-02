import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

Widget IconCard({
  required Widget iconWidget,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: ColorConstant.lightBlue,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: ColorConstant.shadow,
            blurRadius: 5.5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          iconWidget,
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
            )
          ),
        ],
      ),
    ),
  );
}
