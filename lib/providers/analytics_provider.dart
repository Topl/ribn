import 'package:hooks_riverpod/hooks_riverpod.dart';

final analyticsProvider = StateNotifierProvider<AnalyticsNotifier, void>((ref) {
  return AnalyticsNotifier();
});

class AnalyticsNotifier extends StateNotifier<void> {
  AnalyticsNotifier() : super(null);

  // TODO: Implement
  Future<void> optIn() async {}
}
