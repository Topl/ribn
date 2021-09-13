// ignore_for_file: implementation_imports
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:bip_topl/bip_topl.dart';
import 'package:mubrambl/src/crypto/keystore.dart';
import 'package:mubrambl/src/credentials/hd_wallet_helper.dart';
import 'package:ribn/constants/rules.dart';

class OnboardingRespository {
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
    Uint8List toplExtendedPrvKeyUint8List = Uint8List.fromList(toplExtendedKeyPair.privateKey!);
    final String base58EncodedToplExtendedPrvKey = base58Encoder.encode(toplExtendedPrvKeyUint8List);
    final KeyStore keyStore = KeyStore.createNew(
      base58EncodedToplExtendedPrvKey,
      password,
      random,
      scryptN: 4,
    );
    final String keyStoreJson = keyStore.toJson();
    return {
      'mnemonic': mnemonic,
      'keyStoreJson': keyStoreJson,
      'toplExtendedPrvKeyUint8List': toplExtendedPrvKeyUint8List,
    };
  }

  Bip32KeyPair deriveToplExtendedKeys(String mnemonic) {
    final HdWallet hdWallet = HdWallet.fromMnemonic(mnemonic);
    final Bip32KeyPair rootKeys = Bip32KeyPair(
      privateKey: hdWallet.rootSigningKey,
      publicKey: hdWallet.rootVerifyKey,
    );
    final Bip32KeyPair layerOneKeyPair = hdWallet.derive(
      keys: rootKeys,
      index: Rules.defaultPurpose,
    );
    final Bip32KeyPair toplExtendedKeyPair = hdWallet.derive(
      keys: layerOneKeyPair,
      index: Rules.defaultCoinType,
    );
    return toplExtendedKeyPair;
  }
}
