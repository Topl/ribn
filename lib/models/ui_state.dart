import 'dart:convert';

/// A helper class that holds the UI State of Ribn.
class UiState {
  /// A loading indicator used during transfer flows.
  final bool loadingRawTx;

  /// True if there is a faliure in fetching balances.
  final bool failedToFetchBalances;

  /// True if balances are currently being fetched.
  final bool fetchingBalances;

  /// True if restoring wallet fails, e.g. incorrect wallet password when restoring wallet with Topl key.
  final bool failedToRestoreWallet;

  UiState({
    required this.loadingRawTx,
    required this.failedToFetchBalances,
    required this.fetchingBalances,
    required this.failedToRestoreWallet,
  });

  factory UiState.initial() {
    return UiState(
      loadingRawTx: false,
      failedToFetchBalances: false,
      fetchingBalances: false,
      failedToRestoreWallet: false,
    );
  }

  UiState copyWith({
    bool? loadingRawTx,
    bool? failedToFetchBalances,
    bool? fetchingBalances,
    bool? failedToRestoreWallet,
  }) {
    return UiState(
      loadingRawTx: loadingRawTx ?? this.loadingRawTx,
      failedToFetchBalances: failedToFetchBalances ?? this.failedToFetchBalances,
      fetchingBalances: fetchingBalances ?? this.fetchingBalances,
      failedToRestoreWallet: failedToRestoreWallet ?? this.failedToRestoreWallet,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadingRawTx': loadingRawTx,
      'failedToFetchBalances': failedToFetchBalances,
      'fetchingBalances': fetchingBalances,
      'failedToRestoreWallet': failedToRestoreWallet,
    };
  }

  @override
  String toString() {
    return 'UiState(loadingRawTx: $loadingRawTx, failedToFetchBalances: $failedToFetchBalances, fetchingBalances: $fetchingBalances, failedToRestoreWallet: $failedToRestoreWallet)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UiState &&
        other.loadingRawTx == loadingRawTx &&
        other.failedToFetchBalances == failedToFetchBalances &&
        other.fetchingBalances == fetchingBalances &&
        other.failedToRestoreWallet == failedToRestoreWallet;
  }

  @override
  int get hashCode {
    return loadingRawTx.hashCode ^
        failedToFetchBalances.hashCode ^
        fetchingBalances.hashCode ^
        failedToRestoreWallet.hashCode;
  }

  String toJson() => json.encode(toMap());
}
