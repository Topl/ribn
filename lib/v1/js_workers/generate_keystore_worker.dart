// ignore_for_file: avoid_web_libraries_in_flutter

@JS()
library sample;

// Dart imports:
import 'dart:convert';
import 'dart:html';

// Package imports:
import 'package:js/js.dart';

// Project imports:
import 'package:ribn/v1/repositories/onboarding_repository.dart';

@JS('self')
external DedicatedWorkerGlobalScope get self;

/// This is an implementation of a web worker in dart.
/// In order to use it inside the flutter app,
/// it should be compiled into JS using the following command:
///
/// `dart compile js -o ./web/workers/generate_keystore_worker.js lib/js_worker_files/generate_keystore_worker.dart`
///
void main() {
  self.onMessage.listen((e) {
    final Map<String, dynamic> params = jsonDecode(e.data);
    final Map<String, dynamic> results = const OnboardingRespository().generateKeyStore({
      'mnemonic': params['mnemonic'],
      'password': params['password'],
    });
    self.postMessage(jsonEncode(results), null);
  });
}
