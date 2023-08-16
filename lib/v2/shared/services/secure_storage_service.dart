import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  Future<String?> getItem({
    required String key,
  }) async {
    final String? value = await storage.read(key: key);

    return value;
  }
}
