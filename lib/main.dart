import 'package:ebikesms/modules/menu/screen/menu.dart';
import 'package:ebikesms/modules/menu/sub-menu/ride_history/screen/ride_history.dart';
import 'package:ebikesms/modules/menu/sub-menu/settings/screen/settings.dart';
import 'package:ebikesms/modules/menu/sub-menu/time_top_up/screen/time_top_up.dart';
import 'package:flutter/material.dart';
import 'modules/auth/screen/login.dart'; // Adjust the path as needed
import '../../../shared/utils/navigationBar.dart'; // Adjust the path as needed
import 'modules/auth/controller/user_storage_service.dart'; // Adjust the path as needed
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Add dependency in pubspec.yaml

void main() { //async {
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // // Initialize secure storage
  // const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  //
  // // Check if user ID exists in storage
  // String? userId = await secureStorage.read(key: 'userId');
  //
  // runApp(MyApp(isLoggedIn: userId != null));

  runApp(MyApp(isLoggedIn: true));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({
    super.key,
    required this.isLoggedIn
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      //   useMaterial3: true,
      // ),
      //home: const SettingsScreen(),
      home: const MenuScreen(),
    );
  }
}

