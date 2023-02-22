// Dart imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/models/state/login_state.dart';
import 'package:ribn/providers/store_provider.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) => LoginNotifier(ref));

class LoginNotifier extends StateNotifier<LoginState> {
  final Ref ref;

  LoginNotifier(this.ref) : super(LoginState.fromStore(ref.read(storeProvider))) {}
}
