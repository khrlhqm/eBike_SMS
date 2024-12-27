import 'package:flutter/material.dart';
import 'package:ebikesms/modules/admin/widget/reportwidget.dart';
import 'package:ebikesms/modules/admin/report/screen/user_report.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool showIncidentReport = true; // Determines which widget to show

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Navigation Buttons
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        showIncidentReport ? Colors.blue : Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      showIncidentReport = true;
                    });
                  },
                  child: Text(
                    'Incident',
                    style: TextStyle(
                        color: showIncidentReport
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        showIncidentReport ? Colors.grey.shade300 : Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      showIncidentReport = false;
                    });
                  },
                  child: Text(
                    'User',
                    style: TextStyle(
                        color: showIncidentReport
                            ? Colors.black
                            : Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Dynamically Display Incident or User Report Widget
          Expanded(
            child: showIncidentReport
                ? IncidentReportWidget()
                : UserReportWidget(),
          ),
        ],
      ),
    );
  }
}
