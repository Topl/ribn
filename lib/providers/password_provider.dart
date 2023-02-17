import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/models/state/password_state.dart';

/// Provides password state
/// AutoDispose so that when provider is stopped being listened too, all values reset
final passwordProvider = StateProvider.autoDispose<PasswordState>((ref) {
  return PasswordState();
});
