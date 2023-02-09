// Dart imports:
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

// Package imports:
import 'package:bip_topl/bip_topl.dart';
import 'package:brambldart/credentials.dart';
import 'package:brambldart/crypto.dart';

// Project imports:
import 'package:ribn/constants/rules.dart';

class OnboardingRespository {
  const OnboardingRespository();

  /// Generates the mnemonic to be shown to the user.
  ///
  /// Derives the Topl extended private key that follows the path described in [Rules.toplKeyPath].
  ///
  /// The user-provided [password] is used to encrypt the credentials and create a [KeyStore]
  Future<Map> generateMnemonicAndKeystore(String password) async {
    final Random random = Random.secure();
    const Base58Encoder base58Encoder = Base58Encoder.instance;
    final String mnemonic = generateMnemonic(random);
    final Bip32KeyPair toplExtendedKeyPair = deriveToplExtendedKeys(mnemonic);
    final Uint8List toplExtendedPrvKeyUint8List =
        Uint8List.fromList(toplExtendedKeyPair.privateKey!);
    final String base58EncodedToplExtendedPrvKey =
        base58Encoder.encode(toplExtendedPrvKeyUint8List);
    final KeyStore keyStore = KeyStore.createNew(
      base58EncodedToplExtendedPrvKey,
      password,
      random,
      scryptN: Rules.scryptN,
    );
    final String keyStoreJson = keyStore.toJson();
    return {
      'mnemonic': mnemonic,
      'keyStoreJson': keyStoreJson,
      'toplExtendedPrvKeyUint8List': toplExtendedPrvKeyUint8List,
    };
  }

  /// Generates a 15 word mnemonic for the wallet owner.
  String generateMnemonicForUser() {
    final Random random = Random.secure();
    final String mnemonic = generateMnemonic(random, strength: 160);
    return mnemonic;
  }

  Map<String, dynamic> generateKeyStore(Map<String, dynamic> params) {
    const Base58Encoder base58Encoder = Base58Encoder.instance;
    final Random random = Random.secure();
    final Bip32KeyPair toplExtendedKeyPair = deriveToplExtendedKeys(params['mnemonic']);
    final Uint8List toplExtendedPrvKeyUint8List =
        Uint8List.fromList(toplExtendedKeyPair.privateKey!);
    final String base58EncodedToplExtendedPrvKey =
        base58Encoder.encode(toplExtendedPrvKeyUint8List);
    final KeyStore keyStore = KeyStore.createNew(
      base58EncodedToplExtendedPrvKey,
      params['password'],
      random,
      scryptN: Rules.scryptN,
    );
    final String keyStoreJson = keyStore.toJson();
    return {
      'keyStoreJson': keyStoreJson,
      'toplExtendedPrvKeyUint8List': toplExtendedPrvKeyUint8List,
    };
  }

  Bip32KeyPair deriveToplExtendedKeys(String mnemonic) {
    final HdWallet hdWallet = HdWallet.fromMnemonic(mnemonic);
    return hdWallet.deriveBaseAddress(
      purpose: Rules.defaultPurpose,
      coinType: Rules.defaultCoinType,
    );
  }
}
