@JS('ext_storage')
library platform_storage;

import 'dart:async';
import 'dart:convert';

import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/platform/interfaces.dart';

@JS()
external Future<String> getFromLocalStorage();
external Future<void> persistToLocalStorage(String data);
external Future<String> getFromSessionStorage();
external Future<void> saveToSessionStorage(String data);

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

  @override
  Future<void> saveSessionKey(String key) async {
    try {
      final String data = jsonEncode({'toplKey': key});
      await saveToSessionStorage(data);
    } catch (e) {
      if (!Keys.isTestingEnvironment) {
        rethrow;
      }
    }
  }

  @override
  Future<String?> getSessionKey() async {
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
}
