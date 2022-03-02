@JS()
library js_utils;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS()
external void sendMessage();
external void connectToBackground();
external void addPortMessageListener(Function fn);
external void sendPortMessage(String data);
external Future<void> persistToStorage(String data);
external Future<String> fetchData();
external Future<bool> isExtensionView();
external void downloadAsFile(String fileName, String text);
external void deleteWallet();
external Future<void> openAppInNewTab();
external Future<String> getCurrentView();

void initPortMessageListener(Function msgHandler) {
  addPortMessageListener(allowInterop(msgHandler));
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

void closeWindow() {
  window.close();
}

/// Checks if the extension is opened in the default extension-popup view.
Future<bool> openedInExtensionView() {
  return promiseToFuture(isExtensionView());
}

Future<String> getCurrentAppView() {
  return promiseToFuture(getCurrentView());
}
