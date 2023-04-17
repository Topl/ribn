// ignore_for_file: implementation_imports

// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:bip_topl/bip_topl.dart';
import 'package:brambldart/brambldart.dart';

// Project imports:
import 'package:ribn/v1/constants/rules.dart';
import 'package:ribn/v1/models/ribn_address.dart';

class KeychainRepository {
  const KeychainRepository();

  /// Given an instance of [hdWallet] and a valid [networkId],
  /// generates a new address with the derivation path constructed with the provided: [purpose], [coinType],
  /// [account], [change], [addr].
  RibnAddress generateAddress(
    HdWallet hdWallet, {
    int purpose = Rules.defaultPurpose,
    int coinType = Rules.defaultCoinType,
    int account = Rules.defaultAccountIndex,
    int change = Rules.defaultChangeIndex,
    int addr = Rules.defaultAddressIndex,
    required int networkId,
  }) {
    final Bip32KeyPair keyPair = hdWallet.deriveLastThreeLayers(
      account: account,
      change: change,
      address: addr,
    );
    final ToplAddress toplAddress = hdWallet.toBaseAddress(spend: keyPair.publicKey!, networkId: networkId);
    final String keyPath = getKeyPath(purpose, coinType, account, change, addr);
    final RibnAddress newAddress = RibnAddress(
      toplAddress: toplAddress,
      addressIndex: addr,
      changeIndex: change,
      keyPath: keyPath,
      balance: Rules.initBalance(toplAddress.toBase58()),
      networkId: networkId,
    );
    return newAddress;
  }

  /// Constructs the key path, given the indices for [purpose], [coinType], [account], [change], and [address].
  String getKeyPath(
    int purpose,
    int coinType,
    int account,
    int change,
    int address,
  ) {
    String keyPath = 'm/';
    keyPath += isHardened(purpose) ? "${purpose - Rules.hardenedOffset}'/" : '$purpose/';
    keyPath += isHardened(coinType) ? "${coinType - Rules.hardenedOffset}'/" : '$coinType/';
    keyPath += isHardened(account) ? "${account - Rules.hardenedOffset}'/" : '$account/';
    keyPath += isHardened(change) ? "${change - Rules.hardenedOffset}'/" : '$change/';
    keyPath += isHardened(address) ? "${address - Rules.hardenedOffset}'" : '$address';
    return keyPath;
  }

  /// Use [client] to get balances of the target [addresses].
  Future<List<Balance>> getBalances(
    BramblClient client,
    List<ToplAddress> addresses,
  ) async {
    return await client.getAllAddressBalances(addresses);
  }

  /// Get corresponding crendentials of the [addresses] provided, using [hdWallet].
  List<Credentials> getCredentials(
    HdWallet hdWallet,
    List<RibnAddress> addresses,
  ) {
    final List<Credentials> creds = [];
    for (RibnAddress addr in addresses) {
      final Bip32KeyPair keyPair = hdWallet.deriveLastThreeLayers(
        account: addr.accountIndex,
        change: addr.changeIndex,
        address: addr.addressIndex,
      );
      final String base58EncodedPrivKey = Base58Encoder.instance.encode(
        Uint8List.fromList(keyPair.privateKey!),
      );
      creds.add(
        ToplSigningKey.fromString(
          base58EncodedPrivKey,
          addr.networkId,
          addr.toplAddress.proposition,
        ),
      );
    }
    return creds;
  }
}
