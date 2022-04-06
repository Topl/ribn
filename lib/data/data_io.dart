import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Gets persisted app state data from 'app_state.json' - A file that is stored locally.
Future<String> getDataFromLocalStorage() async {
  final File file = File('${(await getApplicationDocumentsDirectory()).path}/app_state.json');
  return await file.readAsString();
}

/// Writes current app state data, i.e. [appStateJson], to a locally stored file 'app_state.json'
Future<void> persistAppState(String appStateJson) async {
  final file = File('${(await getApplicationDocumentsDirectory()).path}/app_state.json');
  await file.writeAsString(appStateJson, flush: true);
}

void connectToBackground() async {
  throw UnimplementedError();
}

void sendPortMessage(String data) {
  throw UnimplementedError();
}

void initPortMessageListener(Function fn) {
  throw UnimplementedError();
}

void closeWindow() {
  throw UnimplementedError();
}

Future<bool> openedInExtensionView() {
  throw UnimplementedError();
}

void downloadAsFile(String fileName, String text) {
  throw UnimplementedError();
}

void deleteWallet() {
  throw UnimplementedError();
}

Future<String> getCurrentAppView() {
  return Future.value('mobile');
}

String getAppVersion() {
  throw UnimplementedError();
}

Future<void> openAppInNewTab() {
  throw UnimplementedError();
}
