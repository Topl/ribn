// Project imports:
import 'package:ribn/v1/models/app_state.dart';
import 'package:ribn/v1/reducers/internal_message_reducer.dart';
import 'package:ribn/v1/reducers/keychain_reducer.dart';
import 'package:ribn/v1/reducers/user_details_reducer.dart';
import 'package:ribn/v1/actions/misc_actions.dart';

/// Main reducer for [AppState]
AppState appReducer(AppState state, dynamic action) {
  if (action is ResetAppStateAction) {
    return AppState.initial();
  } else {
    return AppState(
      keychainState: keychainReducer(state.keychainState, action),
      userDetailsState: userDetailsReducer(state.userDetailsState, action),
      internalMessage: internalMessageReducer(state.internalMessage, action),
    );
  }
}
