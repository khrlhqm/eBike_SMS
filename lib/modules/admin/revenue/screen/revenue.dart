import 'package:flutter/material.dart';
import 'package:ebikesms/shared/widget/bottom_nav_bar.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({super.key});

  @override
  _RevenueScreenState createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revenue Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the Revenue Screen!'),
      ),
    );
  }
}
