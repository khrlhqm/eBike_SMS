import 'package:ebikesms/modules/global_import.dart';

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
                    child: CustomBackButton(
                      buttonColor: ColorConstant.darkBlue,
                      iconSize: 30.0,
                    ),
                  ),
                ],
              ),
            ),

            // Main content with text and two-column boxes layout
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 70),
              child: Column(
                children: [
                  // Heading banner texts
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.darkBlue,
                              ),
                              children: [
                                TextSpan(
                                    text: "Welcome to\n",
                                    style: TextStyle(fontSize: 24)),
                                TextSpan(
                                  text: "eBikeSMS",
                                  style: TextStyle(fontSize: 42),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          TextConstant.appVersion,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: ColorConstant.darkBlue,
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column 1: Single long box (height of two stacked boxes)
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorConstant.lightBlue,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: ColorConstant.shadowlightBlue,
                                offset: Offset(0, 20),
                              )
                            ]
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                            child: Text(
                              'At eBikeSMS, we believe in making transportation easy, eco-friendly, and accessible for all students.\n\nOur mission is to provide a convenient e-bike sharing system that helps you travel across the campus seamlessly.',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: ColorConstant.darkBlue,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                      // Column 2: Two stacked boxes
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: ColorConstant.lightBlue,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: ColorConstant.shadowlightBlue,
                                      offset: Offset(0, 20),
                                    )
                                  ]
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                child: Text(
                                  'An application develop dedicated to help improving mobility of UTeM student.',
                                  style: TextStyle(
                                    color: ColorConstant.darkBlue,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 35), // Space between the two boxes in Column 2

                            // Second box in column 2
                            Container(
                              decoration: BoxDecoration(
                                  color: ColorConstant.lightBlue,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: ColorConstant.shadowlightBlue,
                                      offset: Offset(0, 20),
                                    )
                                  ]
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                child: Text(
                                  'Heading to class, or exploring the university, eBikeSMS is here to empower your journey.',
                                  style: TextStyle(
                                    color: ColorConstant.darkBlue,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 45),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorConstant.darkBlue,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: ColorConstant.shadowdarkBlue,
                                  offset: Offset(0, 25),
                                )
                              ]
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Contact Us',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height:10),

                                // Row for admin 1 and admin 2 information
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(text: 'Admin 1\n'),
                                          TextSpan(text: 'email@domain.com\n'),
                                          TextSpan(text: '123-456-7890'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                // Space between the columns
                                SizedBox(height: 20),

                                // Admin 2 Details
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(text: 'Admin 2\n'),
                                          TextSpan(text: 'email2@domain.com\n'),
                                          TextSpan(text: '987-654-3210'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
