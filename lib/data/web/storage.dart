@JS()
library storage;

import 'package:js/js.dart';
import 'package:js/js_util.dart';

// External JS Class
// https://github.com/dart-lang/sdk/issues/35084
@JS()
class PlatformLocalStorage {
  external PlatformLocalStorage();
  external Future<String> getFromLocalStorageStringified();
  external Future<void> persistToLocalStorage(String data);
}

// Dartify extension methods
extension Dartify on PlatformLocalStorage {
  Future<void> persistToLocalStorageW(String data) async => await promiseToFuture(persistToLocalStorage(data));
}
