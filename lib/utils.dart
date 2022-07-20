import 'dart:ui';

import 'package:brambldart/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/models/app_state.dart';

/// Formats an address string to only dispaly its first and last 10 characters.
String formatAddrString(String addr, {int charsToDisplay = 10}) {
  const numDots = 3;
  final String dotsString = List<String>.filled(numDots, '.').join();
  final String leftSubstring = addr.substring(0, charsToDisplay);
  final String rightSubstring = addr.substring(addr.length - charsToDisplay);
  return '$leftSubstring$dotsString$rightSubstring';
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

/// Formats [unit] to only display the first part of the string.
String formatAssetUnit(String? unit) {
  return unit?.split(' ').first ?? 'Select Unit';
}

/// Validates the [address] passed in by the user.
///
/// Based on the current network, i.e. [networkId], and the [address], [validateAddressByNetwork] validates the address,
/// and [handleResult] is called with the resulting value.
void validateRecipientAddress({
  required String networkName,
  required String address,
  required Function(bool) handleResult,
}) {
  Map<String, dynamic> result = {};
  try {
    result = validateAddressByNetwork(networkName, address);
  } catch (e) {
    result['success'] = false;
  }
  handleResult(result['success']);
}

Future<bool> isBiometricsAuthenticationSupported(LocalAuthentication auth) async {
  final bool canCheckBiometrics = await auth.canCheckBiometrics;
  final bool isDeviceSupported = await auth.isDeviceSupported();
  final List enrolledBiometrics = await auth.getAvailableBiometrics();

  return canCheckBiometrics && isDeviceSupported && enrolledBiometrics.isNotEmpty;
}

Future<bool> authenticateWithBiometrics(LocalAuthentication auth) async {
  return await auth.authenticate(
    localizedReason: 'To authenticate with biometrics',
    options: const AuthenticationOptions(
      stickyAuth: true,
      biometricOnly: true,
      sensitiveTransaction: true,
      useErrorDialogs: true,
    ),
  );
}

Future<bool> isBiometricsTypeFingerprint(LocalAuthentication auth) async {
  final List enrolledBiometrics = await auth.getAvailableBiometrics();

  return enrolledBiometrics.contains(BiometricType.fingerprint) && enrolledBiometrics.isNotEmpty;
}

void navigateToRoute(BuildContext context, String route) {
  StoreProvider.of<AppState>(context).dispatch(NavigateToRoute(route));
}

/// Adapt to screen height based on [scaleFactor].
double adaptHeight(double scaleFactor) => MediaQueryData.fromWindow(window).size.height * scaleFactor;

/// Adapt to screen width based on [scaleFactor].
double adaptWidth(double scaleFactor) => MediaQueryData.fromWindow(window).size.width * scaleFactor;
