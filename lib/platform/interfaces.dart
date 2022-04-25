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
  Future<String> getCurrentAppView();

  /// Closes the current window.
  void closeWindow();
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
}
