import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/providers/packages/local_authentication_provider.dart';
import 'package:ribn/utils/extensions.dart';

import 'logger_provider.dart';

class BiometricsState {
  final bool isSupported;
  final bool isEnabled;
  final bool authorized;

  BiometricsState(
      {this.authorized = false,
      this.isEnabled = false,
      this.isSupported = false});

  // CopyWith method
  BiometricsState copyWith({
    bool? isSupported,
    bool? isEnabled,
    bool? authorized,
  }) {
    return BiometricsState(
      authorized: authorized ?? this.authorized,
      isEnabled: isEnabled ?? this.isEnabled,
      isSupported: isSupported ?? this.isSupported,
    );
  }
}

final biometricsProvider =
    StateNotifierProvider<BiometricsNotifier, AsyncValue<BiometricsState>>(
        (ref) {
  final localAuthentication = ref.read(localAuthenticationProvider).call();
  return BiometricsNotifier(ref, localAuthentication);
});

class BiometricsNotifier extends StateNotifier<AsyncValue<BiometricsState>> {
  final Ref ref;

  static const _biometricsEnabledKey = "biometricsEnabled";

  BiometricsNotifier(this.ref, this._auth) : super(AsyncLoading()) {
    _init();
  }

  _init() async {
    final isSupported = await _isBiometricsAuthenticationSupported();

    if (!isSupported) {
      state = AsyncData(BiometricsState());
      return;
    }

    final isEnabled = await _isBiometricsEnabled();
    state = AsyncData(
        BiometricsState(isSupported: isSupported, isEnabled: isEnabled));
  }

  final LocalAuthentication _auth;

  Future<void> toggleBiometrics({bool? overrideValue}) async {
    final biometrics = state.value; // setup for type promotion
    if (biometrics == null) {
      ProviderContainer().read(loggerPackageProvider).call("Biometrics").warning(
          "Tried to modify biometrics state, before initialization was completed");
      state = AsyncError(
          Exception("Biometrics not initialized"), StackTrace.current);
      return;
    }

    // sets value to Override value, if not supplied default to toggle behaviour
    final isEnabled = overrideValue ?? !biometrics.isEnabled;

    await PlatformLocalStorage.instance
        .saveKVInSecureStorage(_biometricsEnabledKey, isEnabled.toString());
    state = AsyncValue.data(biometrics.copyWith(isEnabled: isEnabled));
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

    return canCheckBiometrics &&
        isDeviceSupported &&
        enrolledBiometrics.isNotEmpty;
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

    return enrolledBiometrics.contains(BiometricType.fingerprint) &&
        enrolledBiometrics.isNotEmpty;
  }

  Future<bool> _isBiometricsEnabled() async {
    return (await PlatformLocalStorage.instance
            .getKVInSecureStorage(_biometricsEnabledKey))
        .toBooleanWithNullableDefault(false);
  }

  Future<bool> _isBiometricsAuthenticationSupported() async {
    // If is web, return false by default
    if (kIsWeb) return false;

    final bool canCheckBiometrics = await _auth.canCheckBiometrics;
    final bool isDeviceSupported = await _auth.isDeviceSupported();

    return canCheckBiometrics && isDeviceSupported;
  }
}
