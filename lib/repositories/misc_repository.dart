import 'package:ribn/data/data.dart' as local;
import 'package:ribn/models/internal_message.dart';

class MiscRepository {
  const MiscRepository();
  Future<void> persistAppState(String appState) async {
    await local.persistAppState(appState);
  }

  void sendInternalMessage(InternalMessage msg) async {
    local.sendPortMessage(msg.toJson());
  }

  void downloadAsFile(String fileName, String text) {
    local.downloadAsFile(fileName, text);
  }

  void deleteWallet() {
    local.deleteWallet();
  }

  Future<bool> isAppOpenedInExtensionView() async {
    return await local.getCurrentAppView() == 'extension';
  }
}
