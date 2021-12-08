import 'package:bip_topl/bip_topl.dart';
import 'package:brambldart/credentials.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/keychain_state.dart';
import 'package:ribn/models/ribn_network.dart';

/// Reducer responsible for updating [KeyChainState]
final keychainReducer = combineReducers<KeychainState>(
  [
    TypedReducer<KeychainState, InitializeHDWalletAction>(_onHdWalletInitialization),
    TypedReducer<KeychainState, UpdateNetworksAction>(_onNetworksUpdated),
    TypedReducer<KeychainState, AddAddressesAction>(_onAddAddresses),
    TypedReducer<KeychainState, UpdateCurrentNetworkAction>(_onNetworkUpdated),
    TypedReducer<KeychainState, UpdateBalancesAction>(_onBalancesUpdated),
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

/// Updates the networks stored in local state with [action.updatedRibnNetworkList].
KeychainState _onNetworksUpdated(KeychainState keychainState, UpdateNetworksAction action) {
  return keychainState.copyWith(
    networks: List.from(action.updatedRibnNetworkList),
  );
}

/// Updates the list of addresses in the current network
KeychainState _onAddAddresses(KeychainState keychainState, AddAddressesAction action) {
  RibnNetwork updatedNetwork = keychainState.currentNetwork.copyWith(
    addresses: List.from(keychainState.currentNetwork.addresses)..addAll(action.addresses),
  );
  return keychainState.copyWith(
    networks: List.from(keychainState.networks)
      ..setAll(
        keychainState.currNetworkIdx,
        [updatedNetwork],
      ),
  );
}

/// Updates the [currNetworkIdx] in [KeychainState].
KeychainState _onNetworkUpdated(KeychainState keychainState, UpdateCurrentNetworkAction action) {
  return keychainState.copyWith(
    currNetworkIdx: keychainState.networks.indexWhere(
      (network) => network.networkId == int.parse(action.networkId),
    ),
  );
}

/// Updates balances for all addresses in the current network
KeychainState _onBalancesUpdated(KeychainState keychainState, UpdateBalancesAction action) {
  RibnNetwork updatedNetwork = keychainState.currentNetwork.copyWith(
    addresses: action.updatedAddresses,
    fetchingBalance: false,
  );
  return keychainState.copyWith(
    networks: List.from(keychainState.networks)
      ..setAll(
        keychainState.currNetworkIdx,
        [updatedNetwork],
      ),
  );
}
