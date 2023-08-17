import 'package:flutter_test/flutter_test.dart';
import 'package:ribn/v2/shared/services/encryption_service.dart';

import '../utils/text_utils.dart';

void main() {
  group('Encryption Tests', () {
    test('Test Encryption', () {
      final encryptionService = EncryptionService();
      encryptionService.encryptString(key: '123456', value: 'Test Value');
    });

    test('Test Successful Decryption', () {
      final String key = getRandomString(6);
      final String value = getRandomString(50);
      final encryptionService = EncryptionService();
      final encrypted = encryptionService.encryptString(key: key, value: value);

      final decrypted = encryptionService.decryptString(encryptedValue: encrypted, key: key);

      expect(decrypted, equals(value));
    });

    test('Test Unsuccessful Decryption due to wrong key', () {
      const String key = '123456';
      const String key2 = '123457';
      final String value = getRandomString(50);
      final encryptionService = EncryptionService();
      final encrypted = encryptionService.encryptString(key: key, value: value + 'wrong');

      try {
        encryptionService.decryptString(encryptedValue: encrypted, key: key2);
      } on ArgumentError catch (e) {
        expect(e.message, equals('Invalid or corrupted pad block'));
      }
    });
  });
}
