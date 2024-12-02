import 'package:flutter/material.dart';
import 'package:ebikesms/modules/menu/screen/menu.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:ebikesms/modules/menu/time_top_up/controller/transaction_controller.dart';
import 'package:ebikesms/shared/utils/custom_icon.dart';
import 'package:ebikesms/shared/utils/calculation.dart';
import 'package:ebikesms/shared/widget/loading_animation.dart';
import 'package:ebikesms/shared/widget/rectangle_button.dart';

class TimeTopUpValidation extends StatefulWidget {
  final int keyedTotal;
  const TimeTopUpValidation({super.key, required this.keyedTotal});
  @override
  State<TimeTopUpValidation> createState() => _TimeTopUpValidationState();
}

class _TimeTopUpValidationState extends State<TimeTopUpValidation> {
  late String transactionDate;
  late int transactionTotal;
  late int obtainedRideTime;
  late int userId;
  bool isSuccessful = false;
  @override
  void initState() {
    super.initState();
    _startValidation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()));
            },
            icon: CustomIcon.close(20, color: ColorConstant.black)),
        title: const Text("Processing Payment"),
        centerTitle: true,
      ),
      body: isSuccessful ? _displaySuccessfulView() : _displayLoadingView(),
    );
  }

  Widget _displayLoadingView() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LoadingAnimation(dimension: 100),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
          child: Text(
            "Processing...",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IntrinsicWidth(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            "Please do not exit this page while it's processing. It may take a few seconds",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ))
      ],
    );
  }

  Widget _displaySuccessfulView() {
    return Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomIcon.checkedColoured(100),
                const Padding(
                  padding: EdgeInsets.fromLTRB(50, 40, 50, 10),
                  child: Text(
                    "Payment Successful",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
            child: RectangleButton(
              label: "Back to menu",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MenuScreen()));
              },
            ),
          ),
        ]));
  }

  void _startValidation() async {
    await _initDetails();
    await _processTransaction();
  }

  Future<void> _initDetails() async {
    String dateTime = await Calculation.getCurrentDateTime();
    setState(() {
      transactionDate = dateTime;
      transactionTotal = widget.keyedTotal;
      obtainedRideTime = Calculation.countRideTimeMinutes(transactionTotal);
      userId = 111; // Get from login
    });
  }

  Future<void> _processTransaction() async {
    var result = await PaymentController.addTransaction(
      transactionDate: transactionDate,
      transactionTotal: transactionTotal,
      obtainedRideTime: obtainedRideTime,
      userId: userId,
    );
    // Error occurred, display a snack bar
    if (result['status'] == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result['message']),
          duration: const Duration(seconds: 2)));
      setState(() {
        isSuccessful = false;
      });
    }
    // Successful
    else if (result['status'] == 1) {
      await Future.delayed(const Duration(seconds: 3, milliseconds: 2));
      setState(() {
        isSuccessful = true;
      });
    }
  }
}
