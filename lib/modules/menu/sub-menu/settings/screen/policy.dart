import 'package:ebikesms/modules/global_import.dart';
import '../../../widget/menu_strip_item.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.hintBlue,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Wave Design and Back Button
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

            // Content Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    "eBikeSMS\nPolicies",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Privacy Policy Section
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),

                  SizedBox(height: 10),

                  // Data Collection
                  Text(
                    "Data Collection",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "We collect the following information from users:\n- Full Name\n- Matric Number\n- Biometric Data (used for account creation, security, and transactions).",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 15),

                  // Purpose of Data Collection
                  Text(
                    "Purpose of Data Collection",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- To create and manage user accounts.\n- To enhance app security and facilitate secure transactions.\n- For analytics purposes to improve the app experience.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 15),

                  // Data Sharing
                  Text(
                    "Data Sharing",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "We do not share user data with any third parties.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 15),

                  // Data Storage and Security
                  Text(
                    "Data Storage and Security",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- User data is stored in a *phpMyAdmin* database.\n- Currently, no encryption is applied to the stored data.\n- *Disclaimer*: We will not be responsible for any data breaches or hacking incidents.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 15),

                  // User Rights
                  Text(
                    "User Rights",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- Users can request to delete their accounts. Once processed, all associated data will be removed.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 15),

                  // Third-Party Services
                  Text(
                    "Third-Party Services",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- We use a trusted payment gateway for all transactions to ensure security during payments.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 30),

                  // Terms of Service Section
                  Text(
                    "Terms of Service",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),

                  SizedBox(height: 10),

                  // User Responsibilities
                  Text(
                    "User Responsibilities",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- Users must handle the e-bike with care and use it properly.\n- Only UTeM students are eligible to create an account.\n- Users must not damage the e-bike; any damages will result in compensation (“ganti rugi”).\n- Users must stay within the designated geo-border. Alarms will trigger if the bike goes beyond this boundary, and time credits will be deducted based on the duration of the breach.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 15),

                  // Prohibited Activities
                  Text(
                    "Prohibited Activities",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- Vandalism of the e-bike or app infrastructure.\n- Sharing accounts with others.\n- Using fake matric numbers to create accounts.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 15),

                  // Liability
                  Text(
                    "Liability",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- Riders/users are responsible for any damages to the bike or accidents occurring during use.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 15),

                  // Payment and Fees
                  Text(
                    "Payment and Fees",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- Pricing, billing cycles, late fees, or penalties for misuse will be displayed after a user makes a payment.\n- The payment gateway will generate a receipt, and users are advised to take a screenshot to save it.\n- All transactions made through the app will be recorded for reference.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 15),

                  // Account Termination
                  Text(
                    "Account Termination",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- Accounts will be terminated if users violate the rules or engage in activities that harm the app, e-bikes, or other users.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 30),

                  // Safety Guidelines Section
                  Text(
                    "Safety Guidelines",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),

                  SizedBox(height: 10),

                  // Riding Tips
                  Text(
                    "Riding Tips",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- Access safe riding tips via the app: go to *Menu > Riding Guide* or *Explore > Mentol Icon*.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 15),

                  // Rules
                  Text(
                    "Rules",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- Adhere to the speed limit set by the university.\n- Park responsibly; violations may result in fines issued by university police.\n- Ride in the left lane and only use the right lane when necessary, such as at roundabouts.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 15),

                  // Emergency Procedures
                  Text(
                    "Emergency Procedures",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- In case of an accident, contact the university’s help line or emergency services (999).",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 30),

                  // App-Specific Details Section
                  Text(
                    "App-Specific Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),

                  SizedBox(height: 10),

                  // Target Audience
                  Text(
                    "Target Audience",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- The app is exclusively for UTeM students.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 15),

                  // Scope of Service
                  Text(
                    "Scope of Service",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- The service is limited to the UTeM campus area.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 15),

                  // Penalties
                  Text(
                    "Penalties",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "- Penalties apply for:\n  - Late bike returns.\n  - Damages to the bike.\n  - Loss of the bike.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  SizedBox(height: 30),

                  // Closing Text
                  Text(
                    "Thank you for using eBikeSMS. Let’s create a smarter, safer, and greener campus together!",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
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
