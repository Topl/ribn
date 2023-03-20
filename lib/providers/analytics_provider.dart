// Dart imports:
import 'dart:async';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/models/state/analytics_state.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/providers/logger_provider.dart';
import 'package:ribn/providers/packages/flutter_secure_storage_provider.dart';
import 'package:ribn/utils/extensions.dart';

final analyticsProvider = StateNotifierProvider<AnalyticsNotifier, AsyncValue<AnalyticsState>>((ref) {
  return AnalyticsNotifier(ref);
});

class AnalyticsNotifier extends StateNotifier<AsyncValue<AnalyticsState>> {
  final Ref ref;

  // Load no analytics tracking as default
  AnalyticsService _service = voidAnalyticsService();

  AnalyticsNotifier(this.ref) : super(AsyncLoading()) {
    _isAnalyticsEnabled().then((isEnabled) {
      state = AsyncData(AnalyticsState(isEnabled: isEnabled));
      if (isEnabled) {
        _service = FirebaseAnalyticsService();
      }
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

    final analytics = state.value; // setup for type promotion
    if (analytics == null) {
      logger.log(
        logLevel: LogLevel.Warning,
        loggerClass: LoggerClass.Analytics,
        message: "Tried to modify analytics state, before initialization was completed",
      );
      state = AsyncError(Exception("Biometrics not initialized"), StackTrace.current);
      return;
    }

    final isEnabled = overrideValue ?? !analytics.isEnabled;

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

    state = AsyncValue.data(analytics.copyWith(isEnabled: isEnabled));
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
