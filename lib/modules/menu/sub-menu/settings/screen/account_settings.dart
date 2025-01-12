import 'package:ebikesms/modules/global_import.dart';
import '../../../widget/menu_tile.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
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
            label: "Reset password",
            labelColor: ColorConstant.black,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountSettingsScreen())
              );
            },
          ),
          MenuTile(
            label: "",
            labelColor: ColorConstant.black,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
