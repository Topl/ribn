@JS()
library ribn_wallet;

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js/js.dart';

// Project imports:
import 'package:ribn/models/app_state.dart';
import '../../constants/keys.dart';

/// Allows assigning a function to be callable from `window.functionName()`
@JS()
external set getWalletBalance(String Function() f);

@JS()
external set getWalletAddress(String Function() f);

@JS()
external String getBalance(void Function() f);

@JS()
external String getAddress(void Function() f);

void initialize() {
  getWalletBalance = allowInterop(_getBalance);
  getWalletAddress = allowInterop(_getAddress);
  // JavaScript code may now call `functionName()` or `window.functionName()`.
}

String _getBalance() =>
    StoreProvider.of<AppState>(Keys.navigatorKey.currentContext!)
        .state
        .keychainState
        .currentNetwork
        .getPolysInWallet()
        .toString();

String _getAddress() =>
    StoreProvider.of<AppState>(Keys.navigatorKey.currentContext!)
        .state
        .keychainState
        .currentNetwork
        .addresses
        .first
        .toplAddress
        .toBase58();
