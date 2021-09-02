// ignore_for_file: implementation_imports
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:bip_topl/bip_topl.dart';
import 'package:mubrambl/src/crypto/keystore.dart';
import 'package:ribn/constants/rules.dart';

class OnboardingRespository {
  final Cip1852KeyTree cip1852keyTree;
  OnboardingRespository({
    required this.cip1852keyTree,
  });

  /// Generates mnemonic to be shown to the user
  /// Derives the Topl extended private key that follows the path described in [Rules.toplKeyPath]
  ///
  /// The user-provided [password] is used to encrypt the credentials and create a [KeyStore]
  Future<Map> generateMnemonicAndKeystore(String password) async {
    final Random random = Random.secure();
    const Base58Encoder base58Encoder = Base58Encoder.instance;
    final String mnemonic = generateMnemonic(random);
    final Bip32Key rootBip32Key = cip1852keyTree.master(mnemonicToSeed(mnemonic));
    cip1852keyTree.root = rootBip32Key;
    final Bip32Key toplExtendedPrvKey = cip1852keyTree.pathToKey(Rules.toplKeyPath);
    final String base58EncodedToplExtendedPrvKey = base58Encoder.encode(
      Uint8List.fromList(
        [...toplExtendedPrvKey.keyBytes, ...toplExtendedPrvKey.chainCode],
      ),
    );
    final KeyStore keyStore =
        KeyStore.createNew(base58EncodedToplExtendedPrvKey, password, random, scryptN: 4);
    final String keyStoreJson = keyStore.toJson();
    return {
      'mnemonic': mnemonic,
      'keyStoreJson': keyStoreJson,
    };
  }
}
