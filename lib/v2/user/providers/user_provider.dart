import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/shared/services/encryption_service.dart';
import 'package:ribn/v2/shared/services/secure_storage_service.dart';
import 'package:ribn/v2/user/constants/constants.dart';
import 'package:ribn/v2/user/models/user.dart';

// Writing some thoughts here too
/// This may seem like overkill to use both secure storage AND encryption
/// but in reality and doesn't add much complexity and adds a lot of security
/// Also for the web version `Flutter Secure Storage` is using an "experimental implementation using WebCrypto"
///
/// One concern is that the key for encryption is only a 6 digit pin
/// Maybe we should require a longer and more complex password on web for more security?

final userProvider = StateNotifierProvider<UserNotifier, AsyncValue<User?>>((ref) {
  return UserNotifier(ref);
});

class UserNotifier extends StateNotifier<AsyncValue<User?>> {
  final Ref ref;

  UserNotifier(this.ref) : super(AsyncLoading());

  Future<void> saveUser({
    required String pin,
    required String mnemonic,
  }) async {
    state = AsyncLoading();

    // Save mnemonic
    final encryptedMnemonic = EncryptionService().encryptString(value: mnemonic, key: pin);
    await SecureStorage().setItem(
      key: mnemonicSecureStorageKey,
      value: encryptedMnemonic,
    );

    // Set State
    state = AsyncData(User(mnemonic: mnemonic));
  }

  Future<void> logUserIn({
    required String pin,
  }) async {
    state = AsyncLoading();

    final String? encryptedMnemonic = await SecureStorage().getItem(key: mnemonicSecureStorageKey);

    if (encryptedMnemonic == null) {
      state = AsyncError('No mnemonic found', StackTrace.current);
      throw Exception('No mnemonic found');
    }

    try {
      final String? mnemonic = EncryptionService().decryptString(encryptedValue: encryptedMnemonic, key: pin);

      if (mnemonic == null) {
        state = AsyncError('Invalid PIN', StackTrace.current);
        throw Exception('Invalid PIN');
      }
      state = AsyncData(User(
        mnemonic: mnemonic,
      ));
    } catch (e) {
      state = AsyncError('Invalid PIN', StackTrace.current);
      throw Exception('Invalid PIN');
    }
  }

  /// Checks if the user is saved
  Future<bool> isUserSaved() async {
    try {
      final String? encryptedMnemonic = await SecureStorage().getItem(key: mnemonicSecureStorageKey);
      return encryptedMnemonic != null;
    } catch (e) {
      print('Error checking if user is saved: $e');
      return false;
    }
  }

  void logOut() {
    // TODO Implement
    state = AsyncValue.data(null);
    ;
  }
}
