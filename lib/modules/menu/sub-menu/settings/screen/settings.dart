import 'package:ebikesms/modules/menu/sub-menu/settings/screen/account_settings.dart';
import 'package:flutter/material.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:ebikesms/modules/menu/screen/menu.dart';
import '../../../widget/menu_strip_item.dart';
import '../../../../../shared/utils/custom_icon.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuScreen()));
          },
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
              label: "Account",
              textColor: ColorConstant.black,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountSettingsScreen()));
              },
          ),
          StripMenuItem(
              label: "Policy",
              textColor: ColorConstant.black,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountSettingsScreen()));
              },
          ),
          StripMenuItem(
              label: "About",
              textColor: ColorConstant.black,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountSettingsScreen()));
              },
          ),
        ],
      ),
    );
  }
}
