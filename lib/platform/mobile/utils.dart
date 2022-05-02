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
  Future<String> getCurrentAppView() {
    return Future.value('mobile');
  }

  @override
  void closeWindow() => throw UnimplementedError();
}
