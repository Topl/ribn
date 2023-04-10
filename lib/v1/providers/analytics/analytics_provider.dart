// Dart imports:
import 'dart:async';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v1/models/state/analytics_state.dart';
import 'package:ribn/v1/platform/platform.dart';
import 'package:ribn/v1/providers/analytics/analytics_events.dart';
import 'package:ribn/v1/providers/analytics/analytics_service.dart';
import 'package:ribn/v1/providers/logger_provider.dart';
import 'package:ribn/v1/providers/packages/flutter_secure_storage_provider.dart';
import 'package:ribn/v1/utils/extensions.dart';

// Project imports:

final analyticsProvider = StateNotifierProvider<AnalyticsNotifier, AnalyticsState>((ref) {
  return AnalyticsNotifier(ref);
});

class AnalyticsNotifier extends StateNotifier<AnalyticsState> {
  final Ref ref;

  // Load no analytics tracking as default
  AnalyticsService _service = VoidAnalyticsService();

  AnalyticsNotifier(this.ref) : super(AnalyticsState()) {
    _isAnalyticsEnabled().then((isEnabled) {
      state = state.copyWith(isEnabled: isEnabled);
      if (isEnabled) {
        _service = FirebaseAnalyticsService(ref);
      }
    });
  }

  Future<void> log(String name, Map<String, dynamic> parameters) async {
    if (_service is VoidAnalyticsService) return;
    await _service.logCustomEvent(name, parameters);
  }

  Future<void> logEventWithBuilder(AnalyticsEventData data) async {
    if (_service is VoidAnalyticsService) return;
    await _service.logEventWithBuilder(data);
  }

  static const _analyticsEnabledKey = "biometricsEnabled";

  /***
   * Toggles analytics and persists it to storage.
   * Allows you to set an override value
   */
  Future toggleAnalytics({bool? overrideValue}) async {
    final logger = ref.read(loggerProvider);

    final isEnabled = overrideValue ?? !state.isEnabled;

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

    state = state.copyWith(isEnabled: isEnabled);
  }

  Future<bool> _isAnalyticsEnabled() async {
    return (await PlatformLocalStorage.instance
            .getKVInSecureStorage(_analyticsEnabledKey, override: ref.read(flutterSecureStorageProvider)()))
        .toBooleanWithNullableDefault(false);
  }

  void setUserType(UserType type) {
    ref.read(loggerProvider).log(
          logLevel: LogLevel.Info,
          loggerClass: LoggerClass.Analytics,
          message: "User type set to: ${type.toString()}",
        );

    state = state.copyWith(userType: type);
  }
}
