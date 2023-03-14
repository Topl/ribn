@JS('ext_storage')
library platform_storage;

// Dart imports:
import 'dart:async';
import 'dart:convert';

// Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';

// Project imports:
import 'package:ribn/constants/keys.dart';
import 'package:ribn/platform/interfaces.dart';

@JS()
external Future<String> getFromLocalStorage();
external Future<void> persistToLocalStorage(String data);
external Future<String> getFromSessionStorage();
external Future<void> saveToSessionStorage(String data);
external Future<void> extClearSessionStorage();

class PlatformLocalStorage implements IPlatformLocalStorage {
  PlatformLocalStorage._internal();
  static PlatformLocalStorage? _instance;
  factory PlatformLocalStorage() {
    _instance ??= PlatformLocalStorage._internal();
    return _instance!;
  }
  static PlatformLocalStorage get instance => PlatformLocalStorage();

  @override
  Future<void> saveState(String data) => promiseToFuture(persistToLocalStorage(data));

  @override
  Future<String> getState() => promiseToFuture(getFromLocalStorage());

  /// Web-only: Saves [key] in `chrome.storage.session`
  @override
  Future<void> saveKeyInSessionStorage(String key) async {
    try {
      final String data = jsonEncode({'toplKey': key});
      await saveToSessionStorage(data);
    } catch (e) {
      if (!Keys.isTestingEnvironment) {
        rethrow;
      }
    }
  }

  /// Web-only: Gets toplKey from `chrome.storage.session` if it exists
  @override
  Future<String?> getKeyFromSessionStorage() async {
    try {
      final Map<String, dynamic> sessionStorage = jsonDecode(await promiseToFuture(getFromSessionStorage()));
      return sessionStorage['toplKey'];
    } catch (e) {
      if (!Keys.isTestingEnvironment) {
        rethrow;
      }
    }
    return null;
  }

  @override
  Future<void> clearSessionStorage() async {
    try {
      return promiseToFuture(extClearSessionStorage());
    } catch (e) {
      if (!Keys.isTestingEnvironment) rethrow;
    }
  }

  /// Mobile-only
  @override
  Future<void> clearSecureStorage() => throw UnimplementedError();

  /// Mobile-only
  @override
  Future<String?> getKeyFromSecureStorage({FlutterSecureStorage? override}) => throw UnimplementedError();

  /// Mobile-only
  @override
  Future<void> saveKeyInSecureStorage(String key, {FlutterSecureStorage? override}) => throw UnimplementedError();

  /// Mobile-only
  @override
  Future<String> getKVInSecureStorage(String key, {FlutterSecureStorage? override}) => throw UnimplementedError();

  /// Mobile-only
  @override
  Future<void> saveKVInSecureStorage(String key, String value, {FlutterSecureStorage? override}) =>
      throw UnimplementedError();
}
