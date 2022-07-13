import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/platform/interfaces.dart';

class PlatformLocalStorage implements IPlatformLocalStorage {
  PlatformLocalStorage._internal();
  static PlatformLocalStorage? _instance;
  factory PlatformLocalStorage() {
    _instance ??= PlatformLocalStorage._internal();
    return _instance!;
  }
  static PlatformLocalStorage get instance => PlatformLocalStorage();

  /// Allows securely storing credentials on mobile.
  /// Uses keychain for iOS; AES encryption and KeyStore for android
  /// Ref: https://pub.dev/packages/flutter_secure_storage
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Future<String> getState() async {
    final File file = File('${(await getApplicationDocumentsDirectory()).path}/app_state.json');
    return await file.readAsString();
  }

  @override
  Future<void> saveState(String data) async {
    final file = File('${(await getApplicationDocumentsDirectory()).path}/app_state.json');
    await file.writeAsString(data, flush: true);
  }

  @override
  Future<String?> getSessionKey() {
    return secureStorage.read(key: 'toplKey');
  }

  @override
  Future<void> saveSessionKey(String key) async {
    try {
      await secureStorage.write(key: 'toplKey', value: key);
    } catch (e) {
      if (!Keys.isTestingEnvironment) {
        rethrow;
      }
    }
  }
}
