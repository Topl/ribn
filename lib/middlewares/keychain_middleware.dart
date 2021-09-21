// ignore_for_file: implementation_imports
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/models/app_state.dart';
import 'package:mubrambl/src/credentials/hd_wallet_helper.dart';
import 'package:ribn/repositories/keychain_repository.dart';

List<Middleware<AppState>> createKeychainMiddleware(KeychainRepository keyChainRepo) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, GenerateInitialAddressesAction>(_onGenerateInitialAddresses(keyChainRepo)),
    TypedMiddleware<AppState, GenerateAddressAction>(_onGenerateAddress(keyChainRepo)),
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
        RibnAddress newAddress = keychainRepo.generateAddress(hdWallet, addr: i);
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
      );
      next(AddAddressesAction(addresses: [newAddress]));
      // Persist AppState after new addresses have been created
      next(PersistAppState());
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}
