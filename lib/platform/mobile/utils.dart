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
  String getCurrentAppVersion() {
    throw UnimplementedError();
  }

  @override
  void downloadFile(String fileName, String text) {
    throw UnimplementedError();
  }

  @override
  void deleteActiveWallet() {
    throw UnimplementedError();
  }

  @override
  Future<void> openInNewTab() {
    throw UnimplementedError();
  }

  @override
  Future<AppViews> getCurrentAppView() {
    return Future.value(AppViews.mobile);
  }

  @override
  void closeWindow() => throw UnimplementedError();

  @override
  void createLoginSessionAlarm() => throw UnimplementedError();

  @override
  void clearDAppList() {
    throw UnimplementedError();
  }

  @override
  Future getDAppList() {
    throw UnimplementedError();
  }
}
