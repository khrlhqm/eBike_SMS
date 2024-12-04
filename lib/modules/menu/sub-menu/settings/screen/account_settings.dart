import 'package:flutter/material.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';

import '../../../../../shared/utils/custom_icon.dart';
import '../../../widget/menu_strip_item.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () { Navigator.pop(context); },
          child: CustomIcon.back(30),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: ColorConstant.white),
        ),
        backgroundColor: ColorConstant.darkBlue,
      ),
      body: ListView(
        children: [
          StripMenuItem(
            label: "Reset password",
            textColor: ColorConstant.black,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountSettingsScreen()));
            },
          ),
          StripMenuItem(
            label: "",
            textColor: ColorConstant.black,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
