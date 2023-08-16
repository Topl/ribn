import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = new FlutterSecureStorage();

  Future<String?> getItem({
    required String key,
  }) async {
    final String? value = await storage.read(key: key);

    return value;
  }
}
