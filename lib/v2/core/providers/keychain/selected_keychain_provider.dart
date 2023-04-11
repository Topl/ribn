import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/core/models/keychain.dart';

final selectedKeychainNotifierProvider = StateNotifierProvider.autoDispose<SelectedKeychainNotifier, Keychain>((ref) {
  return SelectedKeychainNotifier();
});

class SelectedKeychainNotifier extends StateNotifier<Keychain> {
  SelectedKeychainNotifier() : super(Keychain.topl_mainnet);

  changeKeychain(Keychain keychain) {
    state = keychain;
  }
}
