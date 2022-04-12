import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/reducers/internal_message_reducer.dart';
import 'package:ribn/reducers/keychain_reducer.dart';
import 'package:ribn/reducers/login_reducer.dart';
import 'package:ribn/reducers/onboarding_reducer.dart';
import 'package:ribn/reducers/user_details_reducer.dart';

/// Main reducer for [AppState]
AppState appReducer(AppState state, dynamic action) {
  if (action is ResetAppStateAction) {
    return AppState.initial();
  } else {
    return AppState(
      onboardingState: onboardingReducer(state.onboardingState, action),
      loginState: loginReducer(state.loginState, action),
      keychainState: keychainReducer(state.keychainState, action),
      userDetailsState: userDetailsReducer(state.userDetailsState, action),
      internalMessage: internalMessageReducer(state.internalMessage, action),
      appVersion: state.appVersion,
    );
  }
}
