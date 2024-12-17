import 'package:flutter/material.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:ebikesms/modules/global_import.dart';
import '../../../widget/menu_strip_item.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.hintBlue,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top banner section with image and back button
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Vector_3.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 150,
                    left: 20,
                    child: BackButtonWidget(
                      buttonColor: ColorConstant.darkBlue,
                      iconSize: 30.0,
                    ),
                  ),
                ],
              ),
            ),

            // Main content with text and two-column boxes layout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome to",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),

                  const Row(
                    children: [
                      Text(
                        "eBikeSMS",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.darkBlue,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "ver 1.0.0",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: ColorConstant.darkBlue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20), // Space between the text and the boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column 1: Single long box (height of two stacked boxes)
                      Expanded(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: double.infinity,
                              height:
                                  340, // Longer height for the first box (2 boxes in height)
                              decoration: BoxDecoration(
                                color: ColorConstant.shadowlightBlue,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            Positioned(
                              top: -10,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 330,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: ColorConstant.lightBlue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Add Text to the first box
                                    Text(
                                      'At eBikeSMS, we believe in making transportation easy, eco-friendly, and accessible for all students.\n\nOur mission is to provide a convenient e-bike sharing system that helps you travel across the campus seamlessly',
                                      style: TextStyle(
                                        color: ColorConstant.darkBlue,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Spacer between the columns
                      const SizedBox(width: 20),

                      // Column 2: Two stacked boxes
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First box in column 2
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: ColorConstant.shadowlightBlue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              Positioned(
                                top: -10,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 150,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.lightBlue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Add Text to the second box
                                      Text(
                                        'An application develop dedicated to help improving mobility of UTeM student',
                                        style: TextStyle(
                                          color: ColorConstant.darkBlue,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height:
                                  20), // Space between the two boxes in Column 2
                          // Second box in column 2
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: ColorConstant.shadowlightBlue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              Positioned(
                                top: -10,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 150,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.lightBlue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Add Text to the third box
                                      Text(
                                        'Heading to class, or exploring the university, eBikeSMS is here to empower your journey',
                                        style: TextStyle(
                                          color: ColorConstant.darkBlue,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Bottom larger box
                  Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                      color: ColorConstant.shadowdarkBlue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 160,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: ColorConstant.darkBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        mainAxisAlignment:
                            MainAxisAlignment.start, // Aligning to start (left)
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Aligning children to the left
                        children: [
                          // 'Contact Us' aligned to the left
                          Text(
                            'Contact Us',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  10), // Space between 'Contact Us' and admin info

                          // Row for admin 1 and admin 2 information
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Admin 1 Details
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Admin 1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'email@domain.com',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '123-456-7890',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              // Space between the columns
                              SizedBox(width: 20),
                              // Admin 2 Details
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Admin 2',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'email2@domain.com',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '987-654-3210',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
