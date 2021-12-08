import 'package:redux/redux.dart';
import 'package:ribn/actions/ui_actions.dart';
import 'package:ribn/models/ui_state.dart';

final uiReducer = combineReducers<UiState>(
  [
    TypedReducer<UiState, SetLoadingRawTxAction>(_setLoadingRawTx),
    TypedReducer<UiState, FetchingBalancesAction>(_onFetchingBalances),
    TypedReducer<UiState, SuccessfullyFetchedBalancesAction>(_onSuccessfullyFetchedBalances),
    TypedReducer<UiState, FailedToFetchBalancesAction>(_onFailedToLoadBalances),
  ],
);

UiState _setLoadingRawTx(UiState uiState, SetLoadingRawTxAction action) {
  return uiState.copyWith(loadingRawTx: action.loading);
}

UiState _onFailedToLoadBalances(UiState uiState, FailedToFetchBalancesAction action) {
  return uiState.copyWith(failedToFetchBalances: true, fetchingBalances: false);
}

UiState _onFetchingBalances(UiState uiState, FetchingBalancesAction action) {
  return uiState.copyWith(failedToFetchBalances: false, fetchingBalances: true);
}

UiState _onSuccessfullyFetchedBalances(UiState uiState, SuccessfullyFetchedBalancesAction action) {
  return uiState.copyWith(failedToFetchBalances: false, fetchingBalances: false);
}
