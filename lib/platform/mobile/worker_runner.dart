import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/platform/interfaces.dart';

class PlatformWorkerRunner implements IPlatformWorkerRunner {
  PlatformWorkerRunner._internal();
  static PlatformWorkerRunner? _instance;
  factory PlatformWorkerRunner() {
    _instance ??= PlatformWorkerRunner._internal();
    return _instance!;
  }
  static PlatformWorkerRunner get instance => PlatformWorkerRunner();

  @override
  Future<String> runWorker({
    Function(Map<String, dynamic>)? function,
    final String? workerScript,
    Map<String, dynamic> params = const {},
  }) async {
    if (function == null) throw Exception('Dart isolate requires `function` to not be null');
    if (Keys.isTestingEnvironment) return jsonEncode(function(params));
    try {
      return jsonEncode(await compute(function, params));
    } catch (e) {
      throw Exception('Error running dart isolate');
    }
  }
}
