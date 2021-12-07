import 'package:redux/redux.dart';
import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/models/ui_state.dart';

final uiReducer = combineReducers<UiState>(
  [
    TypedReducer<UiState, SetLoadingRawTxAction>(_setLoadingRawTx),
  ],
);

UiState _setLoadingRawTx(UiState uiState, SetLoadingRawTxAction action) {
  return uiState.copyWith(loadingRawTx: action.loading);
}
