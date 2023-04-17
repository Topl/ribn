// Package imports:
import 'package:bip_topl/bip_topl.dart';
import 'package:brambldart/credentials.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/v1/actions/keychain_actions.dart';
import 'package:ribn/v1/constants/rules.dart';
import 'package:ribn/v1/models/keychain_state.dart';
import 'package:ribn/v1/models/ribn_network.dart';

/// Reducer responsible for updating [KeyChainState]
final keychainReducer = combineReducers<KeychainState>(
  [
    TypedReducer<KeychainState, InitializeHDWalletAction>(
      _onHdWalletInitialization,
    ),
    TypedReducer<KeychainState, UpdateNetworksWithAddressesAction>(
      _onNetworksUpdated,
    ),
    TypedReducer<KeychainState, AddAddressAction>(_onAddAddresses),
    TypedReducer<KeychainState, UpdateCurrentNetworkAction>(
      _onCurrentNetworkUpdated,
    ),
    TypedReducer<KeychainState, UpdateBalancesAction>(_onBalancesUpdated),
  ],
);

/// Creates a new [HdWallet] upon successful login, where root = toplExtendedPrivateKey.
///
/// Optionally updates the [keyStoreJson], for instance, when creating a new wallet for the first time.
KeychainState _onHdWalletInitialization(
  KeychainState keychainState,
  InitializeHDWalletAction action,
) {
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

/// Updates ribn networks with [action.networkAddresses].
KeychainState _onNetworksUpdated(
  KeychainState keychainState,
  UpdateNetworksWithAddressesAction action,
) {
  final Map<String, RibnNetwork> networks = Map.from(keychainState.networks);
  networks.forEach(
    (networkName, ribnNetwork) {
      networks[networkName] = ribnNetwork.copyWith(
        addresses: action.networkAddresses[networkName],
      );
    },
  );
  return keychainState.copyWith(networks: networks);
}

/// Add [action.addresses] to the list of addresses under the network specified by [action.networkName].
KeychainState _onAddAddresses(
  KeychainState keychainState,
  AddAddressAction action,
) {
  final RibnNetwork network = keychainState.networks[action.networkName]!;
  final RibnNetwork updatedNetwork = network.copyWith(
    addresses: List.from(network.addresses)..add(action.address),
  );
  return keychainState.copyWith(
    networks: {
      ...keychainState.networks,
      action.networkName: updatedNetwork,
    },
  );
}

/// Updates the current network in [KeychainState].
///
/// More specifically, updates the [keychainState.currentNetworkName] and the [lastCheckedTimestamp] of the network associated with
/// [action.networkName].
KeychainState _onCurrentNetworkUpdated(
  KeychainState keychainState,
  UpdateCurrentNetworkAction action,
) {
  return keychainState.copyWith(
    currentNetworkName: action.networkName,
    networks: {
      ...keychainState.networks,
      action.networkName: keychainState.networks[action.networkName]!.copyWith(
        lastCheckedTimestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    },
  );
}

/// Updates the current network with a list of addresses that have updated balances.
KeychainState _onBalancesUpdated(
  KeychainState keychainState,
  UpdateBalancesAction action,
) {
  return keychainState.copyWith(
    networks: {
      ...keychainState.networks,
      keychainState.currentNetworkName: keychainState.currentNetwork.copyWith(
        addresses: action.updatedAddresses,
      )
    },
  );
}
