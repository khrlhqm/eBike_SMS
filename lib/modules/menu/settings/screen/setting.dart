import 'package:ebikesms/modules/menu/settings/screen/accountSetting.dart';
import 'package:flutter/material.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ebikesms/modules/menu/screen/menu.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: ColorConstant.white),
        ),
        backgroundColor: ColorConstant.darkBlue,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MenuApp(),
              ),
            );
          },
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            width: 24,
            height: 24,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Account'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountSettingsPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Policy'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('About'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
