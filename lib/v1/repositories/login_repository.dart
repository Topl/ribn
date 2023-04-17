// ignore_for_file: implementation_imports

// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:bip_topl/bip_topl.dart';
import 'package:brambldart/crypto.dart';

class LoginRepository {
  const LoginRepository();

  /// Decrypt [keyStoreJson] to get topl's extended private key
  ///
  /// [params] must have a `keyStoreJson` and `password`.
  Uint8List decryptKeyStore(Map<String, dynamic> params) {
    const Base58Encoder base58Encoder = Base58Encoder.instance;
    final KeyStore keyStore = KeyStore.fromV1Json(params['keyStoreJson'], params['password']);
    final Uint8List toplExtendedPrvKeyUint8List = base58Encoder.decode(keyStore.privateKey);
    return toplExtendedPrvKeyUint8List;
  }
}
