import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

class SecureStorage {
  Future<String?> getItem({
    required String key,
  }) async {
    final String? value = await storage.read(key: key);
    return value;
  }

  Future<void> setItem({
    required String key,
    required String value,
  }) async {
    await storage.write(key: key, value: value);
  }

  Future<void> deleteItem({required String key}) async {
    await storage.delete(key: key);
  }
}
