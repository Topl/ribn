class ToggleLoadingRawTxAction {
  final bool loading;
  const ToggleLoadingRawTxAction(this.loading);
}

class ToggleLoadingSignAndBroadcastTxAction {
  final bool loading;
  const ToggleLoadingSignAndBroadcastTxAction(this.loading);
}

class FailedToCreateRawTxAction {
  const FailedToCreateRawTxAction();
}

class FailedToSignAndBroadcastTxAction {
  const FailedToSignAndBroadcastTxAction();
}

class ResetTxUiAction {
  const ResetTxUiAction();
}

class FetchingBalancesAction {
  const FetchingBalancesAction();
}

class FailedToFetchBalancesAction {
  const FailedToFetchBalancesAction();
}

class SuccessfullyFetchedBalancesAction {
  const SuccessfullyFetchedBalancesAction();
}
