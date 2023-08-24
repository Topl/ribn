import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/shared/services/encryption_service.dart';
import 'package:ribn/v2/shared/services/secure_storage_service.dart';
import 'package:ribn/v2/user/constants/constants.dart';
import 'package:ribn/v2/user/models/encrypt_user_data.dart';
import 'package:ribn/v2/user/models/user.dart';

// Writing some thoughts here too
/// This may seem like overkill to use both secure storage AND encryption
/// but in reality and doesn't add much complexity and adds a lot of security
/// Also for the web version `Flutter Secure Storage` is using an "experimental implementation using WebCrypto"
///
/// One concern is that the key for encryption is only a 6 digit pin
/// Maybe we should require a longer and more complex password on web for more security?

final setUserMnemonicProvider = FutureProvider.family<void, EncryptUserData>((ref, userData) async {
  final encryptedMnemonic = EncryptionService().encryptString(value: userData.mnemonic, key: userData.pin);
  await SecureStorage().setItem(
    key: mnemonicSecureStorageKey,
    value: encryptedMnemonic,
  );
  ref.read(userProvider.notifier).setUserMnemonic(userData.mnemonic);
  return;
});

final loadUserProvider = FutureProvider.family<void, String>((ref, pin) async {
  final String? encryptedMnemonic = await SecureStorage().getItem(key: mnemonicSecureStorageKey);
  if (encryptedMnemonic != null) {
    final String? mnemonic = EncryptionService().decryptString(encryptedValue: encryptedMnemonic, key: pin);

    if (mnemonic == null) {
      throw Exception('Invalid PIN');
    }
    ref.read(userProvider.notifier).setUserMnemonic(mnemonic);
  }

  return;
});

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void setUserMnemonic(String mnemonic) {
    state = User(mnemonic: mnemonic);
  }

  void logOut() {
    // TODO Implement
  }
}
