import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/models/state/biometrics_state.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/providers/packages/local_authentication_provider.dart';
import 'package:ribn/utils/extensions.dart';
import 'package:redux/redux.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/providers/store_provider.dart';

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

  _init() async {
    final isSupported = await isBiometricsAuthenticationSupported();

    if (!isSupported) {
      state = AsyncData(BiometricsState());
      return;
    }

    final isEnabled = await _isBiometricsEnabled();
    state = AsyncData(BiometricsState(isSupported: isSupported, isEnabled: isEnabled));
  }

  final LocalAuthentication _auth;

  static const _biometricsEnabledKey = "biometricsEnabled";

  updateBiometrics(bool isBiometricsEnabled) {
    final Store<AppState> store = ref.read(storeProvider);

    store.dispatch(
      UpdateBiometricsAction(
        isBiometricsEnabled: isBiometricsEnabled,
      ),
    );
  }

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

    await PlatformLocalStorage.instance
        .saveKVInSecureStorage(_biometricsEnabledKey, isEnabled.toString());

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

  Future<bool> _isBiometricsEnabled() async {
    return (await PlatformLocalStorage.instance.getKVInSecureStorage(_biometricsEnabledKey))
        .toBooleanWithNullableDefault(false);
  }

  Future<bool> isBiometricsAuthenticationSupported() async {
    // If is web, return false by default
    if (kIsWeb) return false;

    final bool canCheckBiometrics = await _auth.canCheckBiometrics;
    final bool isDeviceSupported = await _auth.isDeviceSupported();

    return canCheckBiometrics && isDeviceSupported;
  }
}
