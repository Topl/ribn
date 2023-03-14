// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/models/state/password_state.dart';

/// Provides password state
/// AutoDispose so that when provider is stopped being listened too, all values reset
final AutoDisposeStateProvider<PasswordState> passwordProvider = StateProvider.autoDispose<PasswordState>((ref) {
  return PasswordState();
});
