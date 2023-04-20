// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

final FlagProvider = Provider<Flags>((ref) {
  return kDebugMode ? Flags.debug() : Flags.production();
});

class Flags {
  final bool debugLogin;
  final bool bypassLogin;
  final bool verboseLogging;
  final bool debugMenu;
  final bool mockServer;

  Flags({
    required this.debugLogin,
    required this.bypassLogin,
    required this.verboseLogging,
    required this.debugMenu,
    required this.mockServer,
  });

  /// Production flags
  Flags.production({
    this.debugLogin = false,
    this.bypassLogin = false,
    this.verboseLogging = false,
    this.debugMenu = false,
    this.mockServer = false,
  });

  Flags.debug({
    this.debugLogin = true,
    this.bypassLogin = false,
    this.verboseLogging = true,
    this.debugMenu = true,
    this.mockServer = true,
  });

  Flags.mock({
    this.debugLogin = false,
    this.bypassLogin = false,
    this.verboseLogging = true,
    this.debugMenu = true,
    this.mockServer = true,
  });

  Flags.offline({
    this.debugLogin = false,
    this.bypassLogin = false,
    this.verboseLogging = true,
    this.debugMenu = true,
    this.mockServer = true,
  });
}
