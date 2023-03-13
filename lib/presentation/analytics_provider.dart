import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/providers/logger_provider.dart';
import 'package:ribn/providers/packages/flutter_secure_storage_provider.dart';
import 'package:ribn/utils/extensions.dart';

final analyticsProvider = Provider<Analytics>((ref) {
  return Analytics(ref);
});

class Analytics {
  ProviderRef<Analytics> ref;

  // Allows you to listen to Analytics being initialized and listen for it's final value
  Completer<bool> enabled = Completer();

  // Load no analytics tracking as default
  AnalyticsService _service = voidAnalyticsService();

  Analytics(this.ref) {
    _isAnalyticsEnabled().then((isEnabled) {
      if (isEnabled) {
        _service = FirebaseAnalyticsService();
      }
      enabled.complete(isEnabled);
    });
  }

  void log(String name, Map<String, dynamic> parameters) => _service.logEvent(name, parameters);


  static const _analyticsEnabledKey = "biometricsEnabled";

  /***
   * Toggles analytics and persists it to storage.
   * Allows you to set an override value
   */
  Future toggleAnalytics({bool? overrideValue}) async {
    final logger = ref.read(loggerProvider);
    enabled.future.then((value) async {
      final isEnabled = overrideValue ?? !value;

      await PlatformLocalStorage.instance.saveKVInSecureStorage(_analyticsEnabledKey, (isEnabled).toString(),
          override: ref.read(flutterSecureStorageProvider)());

      if (isEnabled) {
        _service = FirebaseAnalyticsService();
        logger.log(
          logLevel: LogLevel.Info,
          loggerClass: LoggerClass.Analytics,
          message: "Analytics enabled",
        );
      } else {
        _service = voidAnalyticsService();
        logger.log(
          logLevel: LogLevel.Info,
          loggerClass: LoggerClass.Analytics,
          message: "Analytics disabled",
        );
      }
    });
  }

  Future<bool> _isAnalyticsEnabled() async {
    return (await PlatformLocalStorage.instance
            .getKVInSecureStorage(_analyticsEnabledKey, override: ref.read(flutterSecureStorageProvider)()))
        .toBooleanWithNullableDefault(false);
  }
}

abstract class AnalyticsService {
  void logEvent(String name, Map<String, dynamic> parameters);
}

class voidAnalyticsService implements AnalyticsService {
  void logEvent(String name, Map<String, dynamic> parameters) {
    // do nothing
  }
}

class FirebaseAnalyticsService implements AnalyticsService {
  void logEvent(String name, Map<String, dynamic> parameters) {
    // do firebase thing
  }
}
