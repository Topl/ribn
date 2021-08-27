import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:bip_topl/bip_topl.dart';
import 'package:fast_base58/fast_base58.dart';
// ignore: implementation_imports
import 'package:mubrambl/src/crypto/keystore.dart';

class OnboardingRespository {
  Future<Map> generateMnemonicAndKeystore(String password) async {
    final random = Random.secure();
    final String mnemonic = generateMnemonic(random);
    final String base58EncodedMnemonic = Base58Encode(Uint8List.fromList(latin1.encode(mnemonic)));
    final KeyStore keyStore = KeyStore.createNew(base58EncodedMnemonic, password, random);
    final String keyStoreJson = keyStore.toJson();
    return {
      'mnemonic': mnemonic,
      'keyStoreJson': keyStoreJson,
    };
  }
}
