// ignore_for_file: implementation_imports
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/models/app_state.dart';
import 'package:mubrambl/src/credentials/hd_wallet_helper.dart';
import 'package:mubrambl/src/credentials/address.dart';
import 'package:ribn/repositories/keychain_repository.dart';
import 'package:mubrambl/src/model/balances.dart';

List<Middleware<AppState>> createKeychainMiddleware(KeychainRepository keyChainRepo) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, GenerateInitialAddressesAction>(_onGenerateInitialAddresses(keyChainRepo)),
    TypedMiddleware<AppState, GenerateAddressAction>(_onGenerateAddress(keyChainRepo)),
    TypedMiddleware<AppState, RefreshBalancesAction>(_onRefereshBalances(keyChainRepo)),
  ];
}

void Function(Store<AppState> store, GenerateInitialAddressesAction action, NextDispatcher next)
    _onGenerateInitialAddresses(KeychainRepository keychainRepo) {
  return (store, action, next) {
    try {
      int startIndex = Rules.defaultAddressIndex;
      int endIndex = startIndex + Rules.numInitialAddresses;
      List<RibnAddress> newAddresses = [];
      HdWallet hdWallet = action.hdWallet!;
      for (int i = startIndex; i < endIndex; i++) {
        RibnAddress newAddress = keychainRepo.generateAddress(
          hdWallet,
          addr: i,
          networkId: store.state.keychainState.currentNetwork.networkId,
        );
        newAddresses.add(newAddress);
      }
      next(AddAddressesAction(addresses: newAddresses));
      // Persist AppState after new addresses have been created
      next(PersistAppState());
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
      // Persist AppState after new addresses have been created
      next(PersistAppState());
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}

void Function(Store<AppState> store, RefreshBalancesAction action, NextDispatcher next) _onRefereshBalances(
    KeychainRepository keychainRepo) {
  return (store, action, next) async {
    try {
      next(BalancesLoadingAction());
      List<ToplAddress> addresses =
          store.state.keychainState.currentNetwork.addresses.map((addr) => addr.address).toList();
      List<Balance> balances = await keychainRepo.getBalances(
        store.state.keychainState.currentNetwork.client!,
        addresses,
      );
      Map<String, Balance> addrBalanceMap = {for (Balance bal in balances) bal.address: bal};
      List<RibnAddress> updatedAddresses = store.state.keychainState.currentNetwork.addresses.map((addr) {
        return addr.copyWith(
          balance: addrBalanceMap[addr.address.toBase58()],
        );
      }).toList();
      next(UpdateBalancesAction(updatedAddresses));
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}
