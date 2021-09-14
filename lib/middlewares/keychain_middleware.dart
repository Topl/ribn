// ignore_for_file: implementation_imports
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/models/app_state.dart';
import 'package:mubrambl/src/credentials/hd_wallet_helper.dart';
import 'package:mubrambl/src/credentials/address.dart';

List<Middleware<AppState>> createKeychainMiddleware() {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, GenerateInitialAddressesAction>(_onGenerateInitialAddresses()),
    TypedMiddleware<AppState, GenerateAddressAction>(_onGenerateAddress()),
  ];
}

void Function(Store<AppState> store, GenerateInitialAddressesAction action, NextDispatcher next)
    _onGenerateInitialAddresses() {
  return (store, action, next) {
    try {
      int startIndex = Rules.defaultAddressIndex;
      int endIndex = startIndex + Rules.numInitialAddresses;
      List<RibnAddress> newAddresses = [];
      HdWallet hdWallet = store.state.keychainState.hdWallet!;
      for (int i = startIndex; i < endIndex; i++) {
        Bip32KeyPair keyPair = hdWallet.deriveLastThreeLayers(address: i);
        ToplAddress toplAddress = hdWallet.toBaseAddress(spend: keyPair.publicKey!);
        String keyPath = getKeyPath(
          Rules.defaultPurpose,
          Rules.defaultCoinType,
          Rules.defaultAccountIndex,
          Rules.defaultChangeIndex,
          i,
        );
        RibnAddress newAddress = RibnAddress(address: toplAddress, addressIndex: i, keyPath: keyPath);
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

void Function(Store<AppState> store, GenerateAddressAction action, NextDispatcher next) _onGenerateAddress() {
  return (store, action, next) {
    try {
      HdWallet hdWallet = store.state.keychainState.hdWallet!;
      Bip32KeyPair keyPair = hdWallet.deriveLastThreeLayers(
        address: action.addressIndex,
        account: action.accountIndex,
        change: action.changeIndex,
      );
      ToplAddress toplAddress = hdWallet.toBaseAddress(spend: keyPair.publicKey!);
      String keyPath = getKeyPath(
        Rules.defaultPurpose,
        Rules.defaultCoinType,
        action.accountIndex,
        action.changeIndex,
        action.addressIndex,
      );
      RibnAddress newAddress = RibnAddress(
        address: toplAddress,
        addressIndex: action.addressIndex,
        accountIndex: action.accountIndex,
        changeIndex: action.changeIndex,
        keyPath: keyPath,
      );
      next(AddAddressesAction(addresses: [newAddress]));
      // Persist AppState after new addresses have been created
      next(PersistAppState());
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}

String getKeyPath(int purpose, int coinType, int account, int change, int address) {
  String keyPath = "m/";
  keyPath += isHardened(purpose) ? "${purpose - Rules.hardenedOffset}'/" : "$purpose/";
  keyPath += isHardened(coinType) ? "${coinType - Rules.hardenedOffset}'/" : "$coinType/";
  keyPath += isHardened(account) ? "${account - Rules.hardenedOffset}'/" : "$account/";
  keyPath += isHardened(change) ? "${change - Rules.hardenedOffset}'/" : "$change/";
  keyPath += isHardened(address) ? "${address - Rules.hardenedOffset}'" : "$address";
  return keyPath;
}
