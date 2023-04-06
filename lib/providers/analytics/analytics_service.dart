// Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/providers/analytics/analytics_events.dart';

abstract class AnalyticsService {
  AnalyticsService();

  Future<void> logCustomEvent(String name, Map<String, dynamic> parameters);

  Future<void> logEventWithBuilder(AnalyticsEventData data);
}

// This class acts as a dummy class, It should do nothing.
// I have this class here so that we can be absolutely sure nothing gets logged
// unless we consciously load a different analytics service
class VoidAnalyticsService implements AnalyticsService {
  VoidAnalyticsService();

  Future<void> logCustomEvent(String name, Map<String, dynamic> parameters) async {
    // do nothing
  }

  @override
  Future<void> logEventWithBuilder(AnalyticsEventData data) async {
    // do nothing
  }
}

class FirebaseAnalyticsService implements AnalyticsService {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final Ref ref;

  // Initializes firebase for this application
  FirebaseAnalyticsService(this.ref);

  /***
   * Logs an event to firebase analytics
   * Use the AnalyticsEventBuilders to build the parameters
   */
  Future<void> logCustomEvent(String name, Map<String, dynamic> parameters) async {
    // log event to firebase
    await FirebaseAnalytics.instance.logEvent(name: name, parameters: parameters);
  }

  /** Logs an event to firebase analytics
   * Use the [AnalyticsEventBuilders] to build the [AnalyticsEventData] parameters
   */
  Future<void> logEventWithBuilder(AnalyticsEventData data) async {
    // log event to firebase
    await FirebaseAnalytics.instance.logEvent(name: data.event.name, parameters: data.toMap());
  }
}
