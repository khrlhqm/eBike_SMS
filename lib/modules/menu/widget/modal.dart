import 'package:flutter/material.dart';
import 'package:ebikesms/modules/auth/screen/login.dart';

import '../../../shared/constants/app_constants.dart';

Future<void> logoutModal(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // User must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.center,
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15),
                child:  Center(child: Text('Confirm Logout?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),))
              )
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: ColorConstant.lightGrey))),
            child: ListTile(
              title: const Center(child: Text("Logout", style: TextStyle(color: ColorConstant.red),)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(border: Border(
                    top: BorderSide(color: ColorConstant.lightGrey))
            ),
            child: ListTile(
              title: const Center(child: Text("Cancel")),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}

//
//
// appBar: AppBar(
//   title: const Text(
//   'Learn',
//   style: TextStyle(color: ColorConstant.white),
//   ),
//   backgroundColor: ColorConstant.darkBlue,
//   leading: IconButton(
//     onPressed: () {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuApp()));
//     },
//   icon: SvgPicture.asset('assets/icons/back.svg', width: 24, height: 24)),
// ),


