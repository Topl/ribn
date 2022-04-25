import 'package:ribn/platform/interfaces.dart';

class PlatformLocalStorage implements IPlatformLocalStorage {
  PlatformLocalStorage._internal();
  static PlatformLocalStorage? _instance;
  factory PlatformLocalStorage() {
    _instance ??= PlatformLocalStorage._internal();
    return _instance!;
  }
  static PlatformLocalStorage get instance => PlatformLocalStorage();

  @override
  Future<String> getState() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveState(String data) {
    throw UnimplementedError();
  }
}
