// ignore_for_file: implementation_imports
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:mubrambl/src/credentials/hd_wallet_helper.dart';
import 'package:mubrambl/src/credentials/address.dart';
import 'package:mubrambl/src/core/client.dart';
import 'package:mubrambl/src/model/balances.dart';

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
    Bip32KeyPair keyPair = hdWallet.deriveLastThreeLayers(address: addr);
    ToplAddress toplAddress = hdWallet.toBaseAddress(spend: keyPair.publicKey!, networkId: networkId);
    String keyPath = getKeyPath(purpose, coinType, account, change, addr);
    RibnAddress newAddress = RibnAddress(
      address: toplAddress,
      addressIndex: addr,
      keyPath: keyPath,
      balance: Rules.initBalance(toplAddress.toBase58()),
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
}
