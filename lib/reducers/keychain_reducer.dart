// ignore_for_file: implementation_imports

import 'package:bip_topl/bip_topl.dart';
import 'package:mubrambl/src/credentials/hd_wallet_helper.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/keychain_state.dart';

/// Reducer responsible for updating [KeyChainState]
final keyChainReducer = combineReducers<KeyChainState>(
  [
    TypedReducer<KeyChainState, InitializeHDWalletAction>(_onHdWalletInitialization),
    TypedReducer<KeyChainState, AddAddressesAction>(_onAddAddresses),
  ],
);

/// Creates a new [HdWallet] upon successful login, where root = toplExtendedPrivateKey.
///
/// Optionally updates the [keyStoreJson], for instance, when creating a new wallet for the first time.
KeyChainState _onHdWalletInitialization(KeyChainState keyChainState, InitializeHDWalletAction action) {
  return keyChainState.copyWith(
    keyStoreJson: action.keyStoreJson ?? keyChainState.keyStoreJson,
    hdWallet: HdWallet(
      rootSigningKey: Bip32SigningKey.fromValidBytes(
        action.toplExtendedPrivateKey,
        depth: Rules.toplKeyDepth,
      ),
    ),
  );
}

/// Updates the list of addresses in [KeyChainState].
KeyChainState _onAddAddresses(KeyChainState keyChainState, AddAddressesAction action) {
  return keyChainState.copyWith(
    addresses: keyChainState.addresses.toList()..addAll(action.addresses),
  );
}
