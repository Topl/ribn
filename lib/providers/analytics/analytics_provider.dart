// Dart imports:
import 'dart:async';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/models/state/analytics_state.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/providers/analytics/analytics_events.dart';
import 'package:ribn/providers/analytics/analytics_screen_tracker_provider.dart';
import 'package:ribn/providers/analytics/analytics_service.dart';
import 'package:ribn/providers/analytics/analytics_user_type.dart';
import 'package:ribn/providers/logger_provider.dart';
import 'package:ribn/providers/packages/flutter_secure_storage_provider.dart';
import 'package:ribn/utils/extensions.dart';
import 'analytics_interactions_provider.dart';

final analyticsProvider = StateNotifierProvider<AnalyticsNotifier, AsyncValue<AnalyticsState>>((ref) {
  return AnalyticsNotifier(ref);
});

class AnalyticsNotifier extends StateNotifier<AsyncValue<AnalyticsState>> {
  final Ref ref;

  // Load no analytics tracking as default
  AnalyticsService _service = VoidAnalyticsService();

  AnalyticsNotifier(this.ref) : super(AsyncLoading()) {
    _isAnalyticsEnabled().then((isEnabled) {
      state = AsyncData(AnalyticsState(isEnabled: isEnabled));
      if (isEnabled) {
        // instantiate the following dependencies
        ref.read(analyticsUserTypeProvider); //
        ref.read(analyticsInteractionsProvider);
        ref.read(analyticsScreenTrackerProvider);
        ;

        _service = FirebaseAnalyticsService(ref);
      }
    });
  }

  void log(String name, Map<String, dynamic> parameters) {
    if (_service is VoidAnalyticsService) return;
    _service.logCustomEvent(name, parameters);
  }

  void logEventWithBuilder(AnalyticsEventData data) {
    if (_service is VoidAnalyticsService) return;
    _service.logEventWithBuilder(data);
  }

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
      _service = FirebaseAnalyticsService(ref);
      logger.log(
        logLevel: LogLevel.Info,
        loggerClass: LoggerClass.Analytics,
        message: "Analytics enabled",
      );
    } else {
      _service = VoidAnalyticsService();
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
