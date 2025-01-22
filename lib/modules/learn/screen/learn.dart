import 'package:ebikesms/modules/global_import.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: CustomIcon.back(30),
        ),
        title: const Text(
          'Learn',
          style: TextStyle(color: ColorConstant.white),
        ),
        backgroundColor: ColorConstant.darkBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                TextConstant.greet,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                TextConstant.description,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),

              const SizedBox(height: 32),

              const Text(
                'Tutorial',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                TextConstant.description2,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 16),

              // Tutorial Cards
              SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: List.generate(4, (index) {
      // Tutorial steps data
      final tutorialSteps = [
        {
          "image": "assets/images/scan_qr.jpeg",
          "title": "Scan QR",
          "description": "Scan the QR code on the bike."
        },
        {
          "image": "assets/images/navigation.png",
          "title": "Start Navigation",
          "description": "Start the navigation on the app to find your route."
        },
        {
          "image": "assets/images/choose_location.png",
          "title": "Choose Location",
          "description": "Select your destination from the app."
        },
        {
          "image": "assets/images/start_ride.png",
          "title": "Start Ride",
          "description": "Begin your ride and enjoy the journey."
        },
      ];

      // Access current step data
      final step = tutorialSteps[index];

      return Container(
        width: 300, // Fixed width for each card
        height: 250,
        margin: EdgeInsets.only(right: index < 3 ? 8.0 : 0), // Spacing between cards
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tutorial image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                step["image"]!,
                fit: BoxFit.cover,
                height: 120,
              ),
            ),
            const SizedBox(height: 16),
            // Tutorial title
            Text(
              step["title"]!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Tutorial description
            Text(
              step["description"]!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      );
    }),
  ),
),

            ],
          ),
        ),
      ),
    );
  }
}
