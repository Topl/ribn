import 'package:ribn/constants/rules.dart';

abstract class IPlatformUtils {
  /// Returns the current application version.
  String getCurrentAppVersion();

  /// Download file with name [fileName] and content [content].
  void downloadFile(String fileName, String content);

  /// Clears all locally stored data and closes the window if opened in extension view.
  void deleteActiveWallet();

  /// Opens the app in a new tab, e.g. for onboarding.
  Future<void> openInNewTab();

  /// Returns the current app view.
  Future<AppViews> getCurrentAppView();

  /// Closes the current window.
  void closeWindow();

  void createLoginSessionAlarm();

  /// Web only
  Future<void> clearDAppList();

  /// Web only
  Future getDAppList();

  /// Web only
  void consoleLog(dynamic item);

  /// Web only
  Future<T> convertToFuture<T>(Object jsPromise);
}

abstract class IWallet {
  /// Returns wallet balance
  String getBalance();

  /// Returns wallet address
  String getAddress();
}

abstract class IMessenger {
  /// Send [msg] to the background script.
  void sendMsg(String msg);

  /// Open a long-lived connection with the background script.
  void connect();

  /// Initialize a message listener on the active connection.
  void initMsgListener(Function fn);
}

abstract class IPlatformLocalStorage {
  /// Save [data] to local storage.
  Future<void> saveState(String data);

  /// Get locally stored data.
  Future<String> getState();

  /// Web-only
  ///
  ///  Save [key] in chrome's session storage.
  ///
  /// [key] should be the Base58Encoded Topl Main Key.
  Future<void> saveKeyInSessionStorage(String key);

  /// Mobile-only
  ///
  /// Save [key] in seucre storage for future retrievals.
  ///
  /// [key] should be the Base58Encoded Topl Main Key.
  Future<void> saveKeyInSecureStorage(String key);

  /// Web-only
  ///
  /// Get key, if it exists, from the session storage.
  ///
  /// For chrome, this means accessing session storage using the `chrome.storage.session` API.
  Future<String?> getKeyFromSessionStorage();

  /// Mobile-only
  ///
  ///  Get key, if it exists, from FlutterSecureStorage.
  Future<String?>? getKeyFromSecureStorage();

  /// Web-only
  Future<void> clearSessionStorage();

  /// Mobile-only
  Future<void> clearSecureStorage();
}

abstract class IPlatformWorkerRunner<T> {
  Future<T> runWorker({
    Function(Map<String, dynamic>)? function,
    final String? workerScript,
    Map<String, dynamic> params,
  });
}
