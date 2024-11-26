import 'package:ebikesms/modules/menu/settings/screen/setting.dart';
import 'package:flutter/material.dart';
import 'package:ebikesms/shared/constants/app_constants.dart';
import 'package:flutter_svg/svg.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings > Account',
          style: TextStyle(color: ColorConstant.white),
        ),
        backgroundColor: ColorConstant.darkBlue,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsPage(),
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
            title: const Text('Reset Password'),
            onTap: () {},
          ),
          const Divider(),
        ],
      ),
    );
  }
}
