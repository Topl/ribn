// ignore_for_file: implementation_imports
import 'dart:typed_data';

import 'package:bip_topl/bip_topl.dart';
import 'package:mubrambl/brambldart.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:mubrambl/src/credentials/hd_wallet_helper.dart';
import 'package:mubrambl/src/credentials/address.dart';
import 'package:mubrambl/src/credentials/credentials.dart';
import 'package:mubrambl/src/model/balances.dart';
import 'package:mubrambl/src/utils/proposition_type.dart';

class KeychainRepository {
  const KeychainRepository();
  RibnAddress generateAddress(
    HdWallet hdWallet, {
    int purpose = Rules.defaultPurpose,
    int coinType = Rules.defaultCoinType,
    int account = Rules.defaultAccountIndex,
    int change = Rules.defaultChangeIndex,
    int addr = Rules.defaultAddressIndex,
    required int networkId,
  }) {
    Bip32KeyPair keyPair = hdWallet.deriveLastThreeLayers(account: account, change: change, address: addr);
    ToplAddress toplAddress = hdWallet.toBaseAddress(spend: keyPair.publicKey!, networkId: networkId);
    String keyPath = getKeyPath(purpose, coinType, account, change, addr);
    RibnAddress newAddress = RibnAddress(
      address: toplAddress,
      addressIndex: addr,
      changeIndex: change,
      keyPath: keyPath,
      balance: Rules.initBalance(toplAddress.toBase58()),
      networkId: networkId,
    );
    return newAddress;
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

  Future<List<Balance>> getBalances(
    BramblClient client,
    List<ToplAddress> addresses,
  ) async {
    return await client.getAllAddressBalances(addresses);
  }

  Credentials getCredentials(
    HdWallet hdWallet, {
    int account = Rules.defaultAccountIndex,
    int change = Rules.defaultChangeIndex,
    int addr = Rules.defaultAddressIndex,
    required int networkId,
    PropositionType? propositionType,
  }) {
    Bip32KeyPair keyPair = hdWallet.deriveLastThreeLayers(account: account, change: change, address: addr);
    String base58EncodedPrivKey = Base58Encoder.instance.encode(Uint8List.fromList(keyPair.privateKey!));
    return ToplSigningKey.fromString(
      base58EncodedPrivKey,
      networkId,
      propositionType ?? PropositionType.ed25519(),
    );
  }
}
