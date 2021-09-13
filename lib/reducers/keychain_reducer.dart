// ignore_for_file: implementation_imports

import 'package:bip_topl/bip_topl.dart';
import 'package:mubrambl/src/credentials/hd_wallet_helper.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/keychain_state.dart';

/// Reducer responsible for updating [KeyChainState]
final keyChainReducer = combineReducers<KeychainState>(
  [
    TypedReducer<KeychainState, InitializeHDWalletAction>(_onHdWalletInitialization),
    TypedReducer<KeychainState, AddAddressesAction>(_onAddAddresses),
  ],
);

/// Creates a new [HdWallet] upon successful login, where root = toplExtendedPrivateKey.
///
/// Optionally updates the [keyStoreJson], for instance, when creating a new wallet for the first time.
KeychainState _onHdWalletInitialization(KeychainState keychainState, InitializeHDWalletAction action) {
  return keychainState.copyWith(
    keyStoreJson: action.keyStoreJson ?? keychainState.keyStoreJson,
    hdWallet: HdWallet(
      rootSigningKey: Bip32SigningKey.fromValidBytes(
        action.toplExtendedPrivateKey,
        depth: Rules.toplKeyDepth,
      ),
    ),
  );
}

/// Updates the list of addresses in [KeychainState].
KeychainState _onAddAddresses(KeychainState keychainState, AddAddressesAction action) {
  return keychainState.copyWith(
    addresses: keychainState.addresses.toList()..addAll(action.addresses),
  );
}
