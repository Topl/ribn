import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/providers/logger_provider.dart';
import 'package:ribn/utils/extensions.dart';

final _biometricsEnabledKey = "biometricsEnabled";

final biometricsSupportedProvider = FutureProvider.autoDispose(
    (ref) async => await Biometrics.isBiometricsSupported());

final biometricsEnabledProvider =
    FutureProvider<bool>((ref) async => await Biometrics.isBiometricsEnabled());

final biometricsProvider =
    ChangeNotifierProvider<Biometrics>((ref) => Biometrics());

final localAuthProvider =
    Provider<LocalAuthentication>((ref) => LocalAuthentication());

// final x = StateNotifierProvider<Biometrics>((ref) => Biometrics());

class Biometrics extends ChangeNotifier {
  // Use getter to prevent setting this value outside of this class
  bool? _isEnabled;

  bool? get isEnabled => _isEnabled;

  LocalAuthentication _auth = LocalAuthentication();

  Biometrics() {
    _init();
  }

  bool _authorized = false;

  bool get authorized => _authorized;

  set authorized(bool value) {
    _authorized = value;
    notifyListeners();
  }

  _init() async {
    _isEnabled = await isBiometricsSupported();
  }

  Future<void> toggleBiometrics() async {
    final val = isEnabled; // setup for variable Null Promotion
    if (val == null) {
      ProviderContainer().read(loggerPackageProvider).call("Biometrics").warning(
          "Tried to modify biometrics state, before initialization was completed");

      return;
    }

    _isEnabled = !val;
    await PlatformLocalStorage.instance
        .saveKVInSecureStorage(_biometricsEnabledKey, isEnabled.toString());
    notifyListeners();
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

// static members

  static Future<bool> isBiometricsSupported() async {
    // If is web, return false by default
    if (kIsWeb) return false;

    return await _isBiometricsAuthenticationSupported();
  }

  static Future<bool> isBiometricsEnabled() async {
    return (await PlatformLocalStorage.instance
            .getKVInSecureStorage("biometricsEnabled"))
        .toBooleanWithNullableDefault(false);
  }

  static Future<bool> _isBiometricsAuthenticationSupported() async {
    final auth = LocalAuthentication();

    final bool canCheckBiometrics = await auth.canCheckBiometrics;
    final bool isDeviceSupported = await auth.isDeviceSupported();

    return canCheckBiometrics && isDeviceSupported;
  }
}
