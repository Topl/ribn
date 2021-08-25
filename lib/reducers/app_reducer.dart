import 'package:ribn/models/app_state.dart';
import 'package:ribn/reducers/onboarding_reducer.dart';

/// Main reducer for [AppState]
AppState appReducer(AppState state, dynamic action) {
  return AppState(
    onboardingState: onboardingReducer(state.onboardingState, action),
  );
}
