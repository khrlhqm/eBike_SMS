import 'package:flutter/material.dart';
import "package:ebikesms/modules/admin/report/screen/user_report.dart"; // Import the UserReportScreen

class IncidentReportScreen extends StatelessWidget {
  const IncidentReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incident Report'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Active button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    // Stay on the same screen
                  },
                  child: const Text('Incident'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300, // Inactive button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserReportScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'User',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),   
          ],
        ),
      ),
    );
  }
}
