// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:package_info_plus/package_info_plus.dart';

// Project imports:
import 'package:ribn/constants/rules.dart';
import 'package:ribn/platform/interfaces.dart';

class PlatformUtils implements IPlatformUtils {
  PlatformUtils._internal();
  static PlatformUtils? _instance;
  factory PlatformUtils() {
    _instance ??= PlatformUtils._internal();
    return _instance!;
  }
  static PlatformUtils get instance => PlatformUtils();

  @override
  Future<String> getCurrentAppVersion() async => (await PackageInfo.fromPlatform()).version;

  @override
  void downloadFile(String fileName, String text) => throw UnimplementedError();

  @override
  void deleteActiveWallet() => throw UnimplementedError();

  @override
  Future<void> openInNewTab() => throw UnimplementedError();

  @override
  Future<AppViews> getCurrentAppView() => Future.value(AppViews.mobile);

  @override
  void closeWindow() => throw UnimplementedError();

  @override
  void createLoginSessionAlarm() => throw UnimplementedError();

  @override
  Future clearDAppList() => throw UnimplementedError();

  @override
  Future getDAppList() => throw UnimplementedError();

  @override
  Future<void> consoleLog(dynamic item) async => debugPrint(item);

  @override
  Future<T> convertToFuture<T>(Object jsPromise) => throw UnimplementedError();
}
