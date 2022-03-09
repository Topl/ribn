import 'package:brambldart/brambldart.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/models/ribn_network.dart';
import 'package:ribn/repositories/keychain_repository.dart';

List<Middleware<AppState>> createKeychainMiddleware(KeychainRepository keyChainRepo) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, GenerateInitialAddressesAction>(_onGenerateInitialAddresses(keyChainRepo)),
    TypedMiddleware<AppState, GenerateAddressAction>(_onGenerateAddress(keyChainRepo)),
    TypedMiddleware<AppState, RefreshBalancesAction>(_onRefereshBalances(keyChainRepo)),
  ];
}

/// Generates the initial addresses for each of the networks.
///
/// Dispatches [UpdateNetworksAction] to update the local store with the newly generated addreses.
void Function(Store<AppState> store, GenerateInitialAddressesAction action, NextDispatcher next)
    _onGenerateInitialAddresses(KeychainRepository keychainRepo) {
  return (store, action, next) {
    try {
      final HdWallet hdWallet = action.hdWallet!;
      final List<RibnNetwork> updatedNetworks = store.state.keychainState.networks
          .map(
            (network) => network.copyWith(
              addresses: [
                keychainRepo.generateAddress(
                  hdWallet,
                  networkId: network.networkId,
                )
              ],
            ),
          )
          .toList();
      next(UpdateNetworksAction(updatedNetworks));
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}

void Function(Store<AppState> store, GenerateAddressAction action, NextDispatcher next) _onGenerateAddress(
    KeychainRepository keychainRepo) {
  return (store, action, next) {
    try {
      RibnAddress newAddress = keychainRepo.generateAddress(
        action.hdWallet!,
        account: action.accountIndex,
        change: action.changeIndex,
        addr: action.addressIndex,
        networkId: store.state.keychainState.currentNetwork.networkId,
      );
      next(AddAddressesAction(addresses: [newAddress]));
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}

void Function(Store<AppState> store, RefreshBalancesAction action, NextDispatcher next) _onRefereshBalances(
    KeychainRepository keychainRepo) {
  return (store, action, next) async {
    try {
      // get addresses in the wallet
      final List<ToplAddress> addresses =
          store.state.keychainState.currentNetwork.addresses.map((addr) => addr.address).toList();
      // get balances for all the addresses
      final List<Balance> balances = await keychainRepo.getBalances(
        store.state.keychainState.currentNetwork.client!,
        addresses,
      );
      // map addresses and balances
      final Map<String, Balance> addrBalanceMap = {for (Balance bal in balances) bal.address: bal};
      // addresses with updated balances
      final List<RibnAddress> updatedAddresses = store.state.keychainState.currentNetwork.addresses.map((addr) {
        return addr.copyWith(
          balance: addrBalanceMap[addr.address.toBase58()],
        );
      }).toList();
      next(UpdateBalancesAction(updatedAddresses));

      action.completer.complete(true);
    } catch (e) {
      action.completer.complete(false);
    }
  };
}
