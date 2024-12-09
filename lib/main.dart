import 'package:ebikesms/modules/global_import.dart';
import 'package:ebikesms/modules/menu/screen/menu.dart';
import 'package:ebikesms/modules/menu/sub-menu/ride_history/screen/ride_history.dart';
import 'package:ebikesms/modules/menu/sub-menu/settings/screen/settings.dart';
import 'package:ebikesms/modules/menu/sub-menu/time_top_up/screen/time_top_up.dart';
import 'package:ebikesms/shared/widget/bottom_nav_bar.dart';
import 'package:ebikesms/shared/widget/marker_card.dart';
import 'package:flutter/material.dart';
import 'modules/auth/screen/login.dart'; // Adjust the path as needed
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstant.darkBlue),
        useMaterial3: true,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Poppins'),
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
          displayLarge: TextStyle(fontFamily: 'Poppins'),
          displayMedium: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      home: const BottomNavBar(userId: 888, userType: 'Rider'),
    );
  }
}

