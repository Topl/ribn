/// A helper class that holds the UI State of Ribn.
class UiState {
  /// A loading indicator used during transfer flows.
  final bool loadingRawTx;

  /// True if there is a faliure in fetching balances.
  final bool failedToFetchBalances;

  /// True if balances are currently being fetched.
  final bool fetchingBalances;
  UiState({
    required this.loadingRawTx,
    required this.failedToFetchBalances,
    required this.fetchingBalances,
  });

  factory UiState.initial() {
    return UiState(
      loadingRawTx: false,
      failedToFetchBalances: false,
      fetchingBalances: false,
    );
  }

  UiState copyWith({
    bool? loadingRawTx,
    bool? failedToFetchBalances,
    bool? fetchingBalances,
  }) {
    return UiState(
      loadingRawTx: loadingRawTx ?? this.loadingRawTx,
      failedToFetchBalances: failedToFetchBalances ?? this.failedToFetchBalances,
      fetchingBalances: fetchingBalances ?? this.fetchingBalances,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadingRawTx': loadingRawTx,
      'failedToFetchBalances': failedToFetchBalances,
      'fetchingBalances': fetchingBalances,
    };
  }

  @override
  String toString() =>
      'UiState(loadingRawTx: $loadingRawTx, failedToFetchBalances: $failedToFetchBalances, fetchingBalances: $fetchingBalances)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UiState &&
        other.loadingRawTx == loadingRawTx &&
        other.failedToFetchBalances == failedToFetchBalances &&
        other.fetchingBalances == fetchingBalances;
  }

  @override
  int get hashCode => loadingRawTx.hashCode ^ failedToFetchBalances.hashCode ^ fetchingBalances.hashCode;
}
