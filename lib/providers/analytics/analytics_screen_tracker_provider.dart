// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

final analyticsScreenTrackerProvider = Provider<ScreenTracker>((ref) {
  return ScreenTracker();
});

class ScreenTracker {
  List<String> _screens = [];

  void addScreen(String screen) {
    _screens.add(screen);
  }
}
