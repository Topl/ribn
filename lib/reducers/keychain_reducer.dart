import 'package:bip_topl/bip_topl.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/keychain_state.dart';

final keyChainReducer = combineReducers<KeyChainState>(
  [
    TypedReducer<KeyChainState, LoginSuccessAction>(_onLoginSuccess),
  ],
);

/// Create new Cip1852KeyTree upon successful login, where root = toplExtendedPrivateKey
KeyChainState _onLoginSuccess(KeyChainState keyChainState, LoginSuccessAction action) {
  return keyChainState.copyWith(
    cip1852keyTree: Cip1852KeyTree()
      ..root = Bip32SigningKey.fromValidBytes(
        action.toplExtendedPrivateKey,
        depth: Rules.toplKeyDepth,
      ),
  );
}
