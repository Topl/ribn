import 'package:encrypt/encrypt.dart';

class EncryptionService {
  static const ivLength = 16;

  /// For encryption of filepaths and mnemonics
  String encryptString({
    required String value,
    required String key,
  }) {
    final paddedKey = padKey(key);
    final encryptionKey = Key.fromUtf8(paddedKey);
    final encrypter = Encrypter(AES(encryptionKey));
    final iv = getIV();
    final Encrypted encrypted = encrypter.encrypt(value, iv: iv);

    // Append IV to encrypted string
    final encryptedString = encrypted.base64 + iv.base64;

    return encryptedString;
  }

  /// Returns null if fails to decrypt
  String? decryptString({
    required String encryptedValue,
    required String key,
  }) {
    final paddedKey = padKey(key);
    final encryptionKey = Key.fromUtf8(paddedKey);
    final encrypter = Encrypter(AES(encryptionKey));

    // Get IV from encrypted string
    final iv = IV.fromBase64(encryptedValue.substring(encryptedValue.length - (ivLength + 8)));

    final encryptedString = encryptedValue.substring(0, encryptedValue.length - (ivLength + 8));

    final encryption = Encrypted.fromBase64(encryptedString);
    final decrypted = encrypter.decrypt(encryption, iv: iv);
    return decrypted;
  }

  /// Initialization Vector

  IV getIV() {
    final secureRandom = SecureRandom(ivLength).base64;
    final iv = IV.fromBase64(secureRandom);
    return iv;
  }

  String padKey(String key) {
    final requiredLength = 32;
    return key.padRight(requiredLength, '0');
  }
}
