import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Save the user ID to secure storage
  Future<void> saveUserId(int userId) async {
    await _secureStorage.write(key: 'userId', value: userId.toString());
  }

  // Retrieve the user ID from secure storage
  Future<int?> getUserIdgetUserIdgetUserIdgetUserId() async {
    String? userIdString = await _secureStorage.read(key: 'userId');
    if (userIdString != null) {
      return int.tryParse(userIdString); // Parse the string back to int
    }
    return null; // If no user ID found, return null
  }

  // Delete the user ID from secure storage
  Future<void> deleteUserId() async {
    await _secureStorage.delete(key: 'userId');
  }
}
