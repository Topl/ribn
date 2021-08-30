import 'package:ribn/js.dart' as js;

class MiscRepository {
  Future<void> persistAppState(String appState) async {
    await js.persistAppState(appState);
  }
}
