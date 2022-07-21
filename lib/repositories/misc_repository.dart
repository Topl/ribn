import 'package:ribn/models/internal_message.dart';
import 'package:ribn/platform/platform.dart';

class MiscRepository {
  const MiscRepository();
  Future<void> persistAppState(String appState) async {
    await PlatformLocalStorage.instance.saveState(appState);
  }

  void sendInternalMessage(InternalMessage msg) async {
    Messenger.instance.sendMsg(msg.toJson());
  }

  void downloadAsFile(String fileName, String text) {
    PlatformUtils.instance.downloadFile(fileName, text);
  }
}
