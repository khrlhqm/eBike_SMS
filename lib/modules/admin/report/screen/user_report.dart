import 'package:flutter/material.dart';

class UserReportScreen extends StatefulWidget {
  const UserReportScreen({super.key});

  @override
  _UserReportScreenState createState() => _UserReportScreenState();
}

class _UserReportScreenState extends State<UserReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revenue Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the user report Screen!'),
      ),
    );
  }
}
