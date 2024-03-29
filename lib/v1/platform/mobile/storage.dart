// Dart imports:
import 'dart:io';

// Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:ribn/v1/constants/keys.dart';
import 'package:ribn/v1/platform/interfaces.dart';
import 'package:ribn/v1/providers/packages/flutter_secure_storage_provider.dart';

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
  final FlutterSecureStorage secureStorage = ProviderContainer().read(flutterSecureStorageProvider)();

  @override
  Future<String> getState() async {
    final File file = File(
      '${(await getApplicationDocumentsDirectory()).path}/app_state.json',
    );
    return await file.readAsString();
  }

  @override
  Future<void> saveState(String data) async {
    final file = File(
      '${(await getApplicationDocumentsDirectory()).path}/app_state.json',
    );
    await file.writeAsString(data, flush: true);
  }

  /// Mobile-only: Gets toplKey from encrypted device storage.
  @override
  Future<String?>? getKeyFromSecureStorage({FlutterSecureStorage? override}) async {
    try {
      return (override != null) ? await override.read(key: 'toplKey') : await secureStorage.read(key: 'toplKey');
    } catch (e) {
      if (!Keys.isTestingEnvironment) rethrow;
    }
    return null;
  }

  /// Mobile-only: Saves [key] in encrypted device storage.
  @override
  Future<void> saveKeyInSecureStorage(String key, {FlutterSecureStorage? override}) async {
    try {
      return (override != null)
          ? override.write(key: 'toplKey', value: key)
          : await secureStorage.write(key: 'toplKey', value: key);
    } catch (e) {
      if (!Keys.isTestingEnvironment) rethrow;
    }
  }

  @override
  Future<void> clearSecureStorage() async {
    try {
      return secureStorage.deleteAll();
    } catch (e) {
      if (!Keys.isTestingEnvironment) rethrow;
    }
  }

  /// Web-only
  @override
  Future<void> clearSessionStorage() => throw UnimplementedError();

  /// Web-only
  @override
  Future<String?> getKeyFromSessionStorage({String? key}) => throw UnimplementedError();

  /// Web-only
  @override
  Future<void> saveKeyInSessionStorage(String value, {String? key}) => throw UnimplementedError();

  @override
  Future<String?> getKVInSecureStorage(String key, {FlutterSecureStorage? override}) async {
    try {
      return (override != null) ? await override.read(key: key) : await secureStorage.read(key: key);
    } catch (e) {
      if (!Keys.isTestingEnvironment) rethrow;
    }
    return null;
  }

  @override
  Future<void> saveKVInSecureStorage(String key, String value, {FlutterSecureStorage? override}) async {
    try {
      return (override != null)
          ? await override.write(key: key, value: value)
          : await secureStorage.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }
}
