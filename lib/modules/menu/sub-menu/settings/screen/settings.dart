import 'package:ebikesms/modules/menu/sub-menu/settings/screen/account_settings.dart';
import 'package:ebikesms/modules/global_import.dart';
import 'package:ebikesms/modules/menu/screen/menu.dart';
import '../../../widget/menu_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuScreen()));
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
          MenuTile(
            label: "Account",
            labelColor: ColorConstant.black,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountSettingsScreen()));
            },
          ),
          MenuTile(
            label: "Policy",
            labelColor: ColorConstant.black,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountSettingsScreen()));
            },
          ),
          MenuTile(
            label: "About",
            labelColor: ColorConstant.black,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountSettingsScreen()));
            },
          ),
        ],
      ),
    );
  }
}
