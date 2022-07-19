// ignore_for_file: avoid_web_libraries_in_flutter

@JS()
library sample;

import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:js/js.dart';
import 'package:ribn/repositories/login_repository.dart';

@JS('self')
external DedicatedWorkerGlobalScope get self;

/// This is an implementation of a web worker in dart.
/// In order to use it inside the flutter app,
/// it should be compiled into JS using the following command:
///
/// `dart compile js -o ./web/workers/login_worker.js lib/js_worker_files/login_worker.dart`
///
void main() {
  self.onMessage.listen((e) {
    final Map<String, dynamic> params = jsonDecode(e.data);
    final Uint8List toplExtendedPrvKeyUint8List = const LoginRepository().decryptKeyStore(
      {
        'keyStoreJson': params['keyStoreJson'] as String,
        'password': params['password'] as String,
      },
    );
    self.postMessage(jsonEncode(toplExtendedPrvKeyUint8List), null);
  });
}
