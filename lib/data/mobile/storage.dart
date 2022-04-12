class PlatformLocalStorage {
  Future<String> getFromLocalStorageStringified() {
    throw UnimplementedError();
  }

  Future<void> persistToLocalStorage(String data) {
    throw UnimplementedError();
  }

  Future<void> persistToLocalStorageW(String data) async => await (persistToLocalStorage(data));
}
