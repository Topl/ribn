// Package imports:
import 'package:brambldart/brambldart.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/repositories/keychain_repository.dart';

List<Middleware<AppState>> createKeychainMiddleware(
  KeychainRepository keyChainRepo,
) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, GenerateInitialAddressesAction>(
      _onGenerateInitialAddresses(keyChainRepo),
    ),
    TypedMiddleware<AppState, GenerateAddressAction>(
      _onGenerateAddress(keyChainRepo),
    ),
    TypedMiddleware<AppState, RefreshBalancesAction>(
      _onRefereshBalances(keyChainRepo),
    ),
  ];
}

/// Generates the initial addresses for each of the networks.
///
/// Dispatches [UpdateNetworksWithAddressesAction] to update [RibnNetworks]s with the newly generated addreses.
void Function(
  Store<AppState> store,
  GenerateInitialAddressesAction action,
  NextDispatcher next,
) _onGenerateInitialAddresses(KeychainRepository keychainRepo) {
  return (store, action, next) {
    try {
      final HdWallet hdWallet = store.state.keychainState.hdWallet!;
      final Map<String, List<RibnAddress>> networkAddresses = {};
      store.state.keychainState.networks.forEach((networkName, network) {
        networkAddresses[networkName] = [
          keychainRepo.generateAddress(hdWallet, networkId: network.networkId)
        ];
      });
      next(UpdateNetworksWithAddressesAction(networkAddresses));
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}

/// On receiving [GenerateAddressAction] action, generates a new address and dispatches [AddAddressAction]
/// to add the generated addresses under the current network.
void Function(
  Store<AppState> store,
  GenerateAddressAction action,
  NextDispatcher next,
) _onGenerateAddress(
  KeychainRepository keychainRepo,
) {
  return (store, action, next) async {
    try {
      final RibnAddress newAddress = keychainRepo.generateAddress(
        store.state.keychainState.hdWallet!,
        account: action.accountIndex,
        change: action.changeIndex,
        addr: action.addressIndex,
        networkId: action.network.networkId,
      );
      next(
        AddAddressAction(
          address: newAddress,
          networkName: action.network.networkName,
        ),
      );
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}

/// Responds to [RefreshBalancesAction] by updating balances for the addresses in the wallet under the current network.
///
/// If no addresses exist, a new address is generated.
void Function(
  Store<AppState> store,
  RefreshBalancesAction action,
  NextDispatcher next,
) _onRefereshBalances(
  KeychainRepository keychainRepo,
) {
  return (store, action, next) async {
    print('QQQQ refresh 1');
    try {
      // get addresses in the wallet
      final List<ToplAddress> currentAddresses =
          action.network.addresses.map((addr) => addr.toplAddress).toList();
      print('QQQQ refresh 2');
      // if no address in the wallet, generate a new address
      if (currentAddresses.isEmpty) {
        print('QQQQ refresh 3');
        store.dispatch(GenerateAddressAction(0, network: action.network));
        print('QQQQ refresh 4');
      } else {
        print('QQQQ refresh 5a');
        // get balances for all addresses under the current network
        final List<Balance> balances = await keychainRepo.getBalances(
          store.state.keychainState.currentNetwork.client!,
          currentAddresses,
        );
        print('QQQQ refresh 5');
        // map addresses and balances
        final Map<String, Balance> addrBalanceMap = {
          for (Balance bal in balances) bal.address: bal
        };
        print('QQQQ refresh 6');
        // addresses with updated balances
        final List<RibnAddress> addressesWithUpdatedBalances = action.network.addresses.map(
          (addr) {
            return addr.copyWith(
              balance: addrBalanceMap[addr.toplAddress.toBase58()],
            );
          },
        ).toList();
        next(UpdateBalancesAction(addressesWithUpdatedBalances));

        action.completer.complete(true);
      }
    } catch (e) {
      print('QQQQ error $e');
      action.completer.complete(false);
    }
  };
}
