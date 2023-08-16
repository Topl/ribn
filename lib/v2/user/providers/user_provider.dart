import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/user/models/user.dart';

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
