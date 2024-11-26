import 'package:flutter/material.dart';
import 'package:ebikesms/modules/auth/screen/login.dart';

Future<void> logoutModal(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text('Confirm Logout?'),
              )
            ],
          ),
        ),
        actions: <Widget>[
          ListTile(
            title: const Center(
              child: Text(
                'Log Out',
                style: TextStyle(color: Colors.red),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
          ListTile(
            title: const Center(child: Text('Cancel')),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
