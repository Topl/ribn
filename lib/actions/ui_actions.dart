class SetLoadingRawTxAction {
  final bool loading;
  const SetLoadingRawTxAction(this.loading);
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
