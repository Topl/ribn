@JS('ext_storage')
library platform_storage;

import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:ribn/platform/interfaces.dart';

@JS()
external Future<String> getFromLocalStorageStringified();
external Future<void> persistToLocalStorage(String data);

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
  Future<String> getState() => promiseToFuture(getFromLocalStorageStringified());
}
