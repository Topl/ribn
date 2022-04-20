import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:ribn/platform/interfaces.dart';

class PlatformLocalStorage implements PlatformLocalStorageI {
  PlatformLocalStorage._internal();
  static PlatformLocalStorage? _instance;
  factory PlatformLocalStorage() {
    _instance ??= PlatformLocalStorage._internal();
    return _instance!;
  }
  static PlatformLocalStorage get instance => PlatformLocalStorage();

  @override
  Future<String> getState() async {
    final File file = File('${(await getApplicationDocumentsDirectory()).path}/app_state.json');
    return await file.readAsString();
  }

  @override
  Future<void> saveState(String data) async {
    final file = File('${(await getApplicationDocumentsDirectory()).path}/app_state.json');
    await file.writeAsString(data, flush: true);
  }
}
