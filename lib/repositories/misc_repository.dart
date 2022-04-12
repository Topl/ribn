import 'package:ribn/data/data.dart';
import 'package:ribn/models/internal_message.dart';

class MiscRepository {
  const MiscRepository();
  Future<void> persistAppState(String appState) async {
    await persistAppState(appState);
  }

  void sendInternalMessage(InternalMessage msg) async {
    sendPortMessage(msg.toJson());
  }

  void downloadAsFile(String fileName, String text) {
    downloadAsFile(fileName, text);
  }

  void deleteWallet() {
    deleteWallet();
  }

  Future<bool> isAppOpenedInExtensionView() async {
    return await getCurrentAppView() == 'extension';
  }

  Future<bool> isAppOpenedInDebugView() async {
    return await getCurrentAppView() == 'debug';
  }
}
