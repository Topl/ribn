// ignore_for_file: implementation_imports
import 'dart:typed_data';
import 'package:bip_topl/bip_topl.dart';
import 'package:brambldart/crypto.dart';

class LoginRepository {
  const LoginRepository();

  /// Decrypt [keyStoreJson] to get topl's extended private key
  Uint8List decryptKeyStore({
    required String keyStoreJson,
    required String password,
  }) {
    const Base58Encoder base58Encoder = Base58Encoder.instance;
    final KeyStore keyStore = KeyStore.fromV1Json(keyStoreJson, password);
    final Uint8List toplExtendedPrvKeyUint8List = base58Encoder.decode(keyStore.privateKey);
    return toplExtendedPrvKeyUint8List;
  }
}
