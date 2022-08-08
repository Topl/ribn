// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:ribn/platform/interfaces.dart';

class PlatformWorkerRunner implements IPlatformWorkerRunner {
  PlatformWorkerRunner._internal();
  static PlatformWorkerRunner? _instance;
  factory PlatformWorkerRunner() {
    _instance ??= PlatformWorkerRunner._internal();
    return _instance!;
  }
  static PlatformWorkerRunner get instance => PlatformWorkerRunner();

  /// Ref: https://github.com/flutter/flutter/issues/33577#issuecomment-500609454
  @override
  Future<String> runWorker({
    Function(Map<String, dynamic>)? function,
    final String? workerScript,
    Map<String, dynamic> params = const {},
  }) {
    if (workerScript == null) throw Exception('JS worker requires `workerScript` to not be null');
    try {
      final Completer<String> completer = Completer();
      final Worker worker = Worker(workerScript);
      worker.onMessage.listen((e) {
        worker.terminate();
        completer.complete(e.data);
      });
      final jsonEncodedParams = jsonEncode(params);
      worker.postMessage(jsonEncodedParams);
      return completer.future;
    } catch (e) {
      throw Exception('Error running JS worker');
    }
  }
}
