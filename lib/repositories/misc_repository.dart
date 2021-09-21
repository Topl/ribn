import 'package:ribn/data/data.dart' as local;

class MiscRepository {
  const MiscRepository();
  Future<void> persistAppState(String appState) async {
    await local.persistAppState(appState);
  }
}
