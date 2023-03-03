import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ribn/models/state/biometrics_state.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/providers/packages/local_authentication_provider.dart';
import 'package:ribn/utils/extensions.dart';

import 'logger_provider.dart';

/// Provides biometrics state and functions
final biometricsProvider =
    StateNotifierProvider<BiometricsNotifier, AsyncValue<BiometricsState>>((ref) {
  final localAuthentication = ref.read(localAuthenticationProvider)();
  return BiometricsNotifier(ref, localAuthentication);
});

class BiometricsNotifier extends StateNotifier<AsyncValue<BiometricsState>> {
  final Ref ref;

  BiometricsNotifier(this.ref, this._auth) : super(AsyncLoading()) {
    _init();
  }

  Future<bool> _init() async {
    final isSupported = await _isBiometricsAuthenticationSupported();

    if (!isSupported) {
      state = AsyncData(BiometricsState());
      return false;
    }

    final isEnabled = await isBiometricsEnabled(ref);
    state = AsyncData(BiometricsState(isSupported: isSupported, isEnabled: isEnabled));
    return true;
  }

  final LocalAuthentication _auth;

  static const _biometricsEnabledKey = "biometricsEnabled";

  /***
   * Toggles [state.isEnabled] and resets [state.authorized]
   * @requires [state.authorized] to be true
   */
  Future<void> toggleBiometrics({bool? overrideValue}) async {
    final biometrics = state.value; // setup for type promotion
    final logger = ref.read(loggerPackageProvider)("Biometrics");
    if (biometrics == null) {
      ref.read(loggerProvider).log(
            logLevel: LogLevel.Warning,
            loggerClass: LoggerClass.ApiError,
            message: "Tried to modify biometrics state, before initialization was completed",
          );
      state = AsyncError(Exception("Biometrics not initialized"), StackTrace.current);
      return;
    }

    // guard clause for authorization
    if (!biometrics.authorized) {
      logger.warning("Tried to modify biometrics state without authorization");
      return;
    }

    // sets value to Override value, if not supplied default to toggle behaviour
    final isEnabled = overrideValue ?? !biometrics.isEnabled;

    await saveKVInSecureStorageWithRef(
      _biometricsEnabledKey,
      isEnabled.toString(),
      ref,
    );

    // resets authorized value
    state = AsyncValue.data(biometrics.copyWith(isEnabled: isEnabled, authorized: false));
  }

  void setAuthorization(bool value) {
    final biometrics = state.value; // setup for type promotion
    if (biometrics != null) {
      state = AsyncValue.data(biometrics.copyWith(authorized: value));
    }
  }

  Future<bool> isBiometricsAuthenticationEnrolled() async {
    final bool canCheckBiometrics = await _auth.canCheckBiometrics;
    final bool isDeviceSupported = await _auth.isDeviceSupported();
    final List enrolledBiometrics = await _auth.getAvailableBiometrics();

    return canCheckBiometrics && isDeviceSupported && enrolledBiometrics.isNotEmpty;
  }

  Future<bool> authenticateWithBiometrics() async {
    return await _auth.authenticate(
      localizedReason: 'To authenticate with biometrics',
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: true,
        sensitiveTransaction: true,
        useErrorDialogs: true,
      ),
    );
  }

  Future<bool> isBiometricsTypeFingerprint() async {
    final List enrolledBiometrics = await _auth.getAvailableBiometrics();

    return enrolledBiometrics.contains(BiometricType.fingerprint) && enrolledBiometrics.isNotEmpty;
  }

  Future<bool> _isBiometricsAuthenticationSupported() async {
    // If is web, return false by default
    if (kIsWeb) return false;

    final bool canCheckBiometrics = await _auth.canCheckBiometrics;
    final bool isDeviceSupported = await _auth.isDeviceSupported();

    return canCheckBiometrics && isDeviceSupported;
  }

  static Future<bool> isBiometricsEnabled(ref) async {
    return (await getKVInSecureStorageWithRef(_biometricsEnabledKey, ref))
        .toBooleanWithNullableDefault(false);
  }
}
