import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'package:encrypt/encrypt.dart';

/// For encryption of filepaths and mnemonics
String encryptString({
  required String input,
  required String dek,
}) {
  final key = Key.fromBase64(stringSha256(dek));
  final encrypter = Encrypter(AES(key));
  final iv = IV.fromBase64(base64Encode(random16Bytes()));
  final calculatedHmac = fromBase64(stringSha256(input));
  final encrypted = encrypter.encryptBytes(input.codeUnits + calculatedHmac, iv: iv).bytes;
  return toBase64(Uint8List.fromList(encrypted + iv.bytes));
}

/// Returns null if fails to decrypt
String? decryptString({
  required String base64CipherText,
  required String dek,
}) {
  final key = Key.fromBase64(stringSha256(dek));
  final encrypter = Encrypter(AES(key));
  final encryptedFilepath = fromBase64(base64CipherText);
  if (encryptedFilepath.length > 48) {
    final providedIvBytes = encryptedFilepath.sublist(encryptedFilepath.length - 16);
    final providedIv = IV.fromBase64(toBase64(providedIvBytes));
    final encrypted = Encrypted(encryptedFilepath.sublist(0, encryptedFilepath.length - 16));
    List<int> decrypted = [];
    try {
      decrypted = encrypter.decryptBytes(encrypted, iv: providedIv);
    } on ArgumentError catch (e) {
      //print("Failed to decrypt under new method: ${e}");
    }
    if (decrypted.length > 32) {
      final assumedHmac = decrypted.sublist(decrypted.length - 32);
      final remainder = decrypted.sublist(0, decrypted.length - 32);
      final calculatedHmac = bytesSha256(Uint8List.fromList(remainder));
      if (foundation.listEquals(calculatedHmac, assumedHmac)) {
        return String.fromCharCodes(remainder);
      }
    }
  }
}

/// Returns base64 encoded string
String stringSha256(String input) {
  final hash = sha256.convert(Uint8List.fromList(input.codeUnits)).bytes;
  return toBase64(Uint8List.fromList(hash));
}

/// Encode raw bytes to a Base64 String
String toBase64(Uint8List hash) {
  return base64.encode(hash);
}

Uint8List fromBase64(String encoded) {
  return base64.decode(encoded);
}

String toBase58(Uint8List hash) {
  return base58encode(hash.toList());
}

Uint8List random16Bytes() {
  final random = Random.secure();
  final builder = BytesBuilder();
  for (var i = 0; i < 16; ++i) {
    builder.addByte(random.nextInt(256));
  }
  return builder.toBytes();
}

/// Runs SHA256 algorithm on raw bytes
Uint8List bytesSha256(Uint8List byteList) {
  return Uint8List.fromList(sha256.convert(byteList).bytes);
}
