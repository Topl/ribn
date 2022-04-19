class PlatformLocalStorage {
  PlatformLocalStorage._internal();
  static PlatformLocalStorage? _instance;
  factory PlatformLocalStorage() {
    _instance ??= PlatformLocalStorage._internal();
    return _instance!;
  }
  static PlatformLocalStorage get instance => PlatformLocalStorage();

  Future<void> persistToLocalStorageW(String data) async {
    throw UnimplementedError();
  }

  Future<String> getFromLocalStorageStringifiedW() async {
    throw UnimplementedError();
  }
}
