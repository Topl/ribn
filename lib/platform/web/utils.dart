// ignore_for_file: avoid_web_libraries_in_flutter

@JS('ext_utils')
library ext_utils;

import 'dart:html';

import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:ribn/platform/interfaces.dart';

@JS()
external String getAppVersion();
external void deleteWallet();
external void downloadAsFile(String fileName, String text);
external Future<void> openAppInNewTab();
external Future<String> getCurrentView();

class PlatformUtils implements IPlatformUtils {
  PlatformUtils._internal();
  static PlatformUtils? _instance;
  factory PlatformUtils() {
    _instance ??= PlatformUtils._internal();
    return _instance!;
  }
  static PlatformUtils get instance => PlatformUtils();

  @override
  String getCurrentAppVersion() => getAppVersion();

  @override
  void downloadFile(String fileName, String text) => downloadAsFile(fileName, text);

  @override
  void deleteActiveWallet() => deleteWallet();

  @override
  Future<void> openInNewTab() => promiseToFuture(openAppInNewTab());

  @override
  Future<String> getCurrentAppView() => promiseToFuture(getCurrentView());

  @override
  void closeWindow() => window.close();
}
