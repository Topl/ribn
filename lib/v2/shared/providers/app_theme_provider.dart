import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appThemeColorProvider = StateNotifierProvider<ThemeColorNotifier, ThemeMode>(
  (ref) {
    return ThemeColorNotifier();
  },
);

class ThemeColorNotifier extends StateNotifier<ThemeMode> {
  ThemeColorNotifier() : super(ThemeMode.light);

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
