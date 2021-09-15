@JS()
library js_utils;

import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS()
external void sendMessage();
external void connectToBackground();
external void addMessageListener(Function fn);
external void sendPortMessage(String data);
external Future<void> persistToStorage(String data);
external Future<String> fetchData();

void initMessageListener(Function msgHandler) {
  addMessageListener(allowInterop(msgHandler));
}

/// Calls the JS function [fetchData] defined in "utils.js" to fetch data from local storage
/// [promiseToFuture] converts a javascript promise into a dart [Future]
Future<String> getDataFromLocalStorage() {
  return promiseToFuture(fetchData());
}

/// Calls the JS function [persistToStorage] defined in "utils.js" to persist [data] to local storage
/// [promiseToFuture] converts a javascript promise into a dart [Future]
Future<void> persistAppState(String data) async {
  await promiseToFuture(persistToStorage(data));
}
