import 'package:ebikesms/modules/global_import.dart';
import 'package:flutter/material.dart';
import 'package:ebikesms/modules/menu/sub-menu/user_report/report_controller.dart';

class UserReportScreen extends StatefulWidget {
  const UserReportScreen({Key? key}) : super(key: key);

  @override
  State<UserReportScreen> createState() => _UserReportScreenState();
}

class _UserReportScreenState extends State<UserReportScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedReportType; // Holds the selected report type
  final List<String> _reportTypes = [
    'Bug Report',
    'Feature Request',
    'Account Issue',
    'Other'
  ]; // Options for the dropdown

  final ReportController _reportController = ReportController();

  void _submitReport() async {
  if (_selectedReportType == null || _descriptionController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill in all fields before submitting.')),
    );
    return;
  }

  // Call sendReport and check if the result is 1 (success)
  int result = await _reportController.sendReport(
    context,
    _selectedReportType!,
    _descriptionController.text,
  );

  if (result == 1) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Report submitted successfully!')),
    );
    _descriptionController.clear();
    setState(() {
      _selectedReportType = null;
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to submit report.')),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorConstant.hintBlue, // Light blue background
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Back Button
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF003366)),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 20),
              // Heading
              Text(
                "Having a trouble?",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Feel free to submit a report to us",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              // Report Type Dropdown
              DropdownButtonFormField<String>(
                value: _selectedReportType,
                decoration: InputDecoration(
                  labelText: "Report Type",
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        color: ColorConstant.hintBlue, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        color: ColorConstant.hintBlue, width: 1),
                  ),
                ),
                items: _reportTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedReportType = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Description Input
              TextField(
                controller: _descriptionController,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        color: ColorConstant.hintBlue, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        color: ColorConstant.hintBlue, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Send Report Button
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.07,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedReportType != null &&
                        _descriptionController.text.isNotEmpty) {
                      _submitReport();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please complete all fields'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.darkBlue, // Dark blue
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Send Report",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
