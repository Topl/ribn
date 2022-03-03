import 'dart:convert';

/// A helper class that holds the UI State of Ribn.
class UiState {
  /// True if currently loading to create raw tx.
  final bool loadingRawTx;

  /// True if currently loading to sign and broadcast tx.
  final bool loadingSignAndBroadcastTx;

  /// True if there is a failure trying to create raw tx.
  final bool failedToCreateRawTx;

  /// True if there is a failure when signing & broadcasting tx.
  final bool failedToSignAndBroadcastTx;

  /// True if there is a faliure in fetching balances.
  final bool failedToFetchBalances;

  /// True if balances are currently being fetched.
  final bool fetchingBalances;

  /// True if restoring wallet fails, e.g. incorrect wallet password when restoring wallet with Topl key.
  final bool failedToRestoreWallet;

  UiState({
    required this.loadingRawTx,
    required this.loadingSignAndBroadcastTx,
    required this.failedToCreateRawTx,
    required this.failedToSignAndBroadcastTx,
    required this.failedToFetchBalances,
    required this.fetchingBalances,
    required this.failedToRestoreWallet,
  });

  factory UiState.initial() {
    return UiState(
      loadingRawTx: false,
      loadingSignAndBroadcastTx: false,
      failedToSignAndBroadcastTx: false,
      failedToCreateRawTx: false,
      failedToFetchBalances: false,
      fetchingBalances: false,
      failedToRestoreWallet: false,
    );
  }

  UiState copyWith({
    bool? loadingRawTx,
    bool? loadingSignAndBroadcastTx,
    bool? failedToCreateRawTx,
    bool? failedToSignAndBroadcastTx,
    bool? failedToFetchBalances,
    bool? fetchingBalances,
    bool? failedToRestoreWallet,
  }) {
    return UiState(
      loadingRawTx: loadingRawTx ?? this.loadingRawTx,
      loadingSignAndBroadcastTx: loadingSignAndBroadcastTx ?? this.loadingSignAndBroadcastTx,
      failedToCreateRawTx: failedToCreateRawTx ?? this.failedToCreateRawTx,
      failedToSignAndBroadcastTx: failedToSignAndBroadcastTx ?? this.failedToSignAndBroadcastTx,
      failedToFetchBalances: failedToFetchBalances ?? this.failedToFetchBalances,
      fetchingBalances: fetchingBalances ?? this.fetchingBalances,
      failedToRestoreWallet: failedToRestoreWallet ?? this.failedToRestoreWallet,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadingRawTx': loadingRawTx,
      'loadingSignAndBroadcastTx': loadingSignAndBroadcastTx,
      'failedToCreateRawTx': failedToCreateRawTx,
      'failedToSignAndBroadcastTx': failedToSignAndBroadcastTx,
      'failedToFetchBalances': failedToFetchBalances,
      'fetchingBalances': fetchingBalances,
      'failedToRestoreWallet': failedToRestoreWallet,
    };
  }

  @override
  String toString() {
    return 'UiState(loadingRawTx: $loadingRawTx, loadingSignAndBroadcastTx: $loadingSignAndBroadcastTx, failedToCreateRawTx: $failedToCreateRawTx, failedToSignAndBroadcastTx: $failedToSignAndBroadcastTx, failedToFetchBalances: $failedToFetchBalances, fetchingBalances: $fetchingBalances, failedToRestoreWallet: $failedToRestoreWallet)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UiState &&
        other.loadingRawTx == loadingRawTx &&
        other.loadingSignAndBroadcastTx == loadingSignAndBroadcastTx &&
        other.failedToCreateRawTx == failedToCreateRawTx &&
        other.failedToSignAndBroadcastTx == failedToSignAndBroadcastTx &&
        other.failedToFetchBalances == failedToFetchBalances &&
        other.fetchingBalances == fetchingBalances &&
        other.failedToRestoreWallet == failedToRestoreWallet;
  }

  @override
  int get hashCode {
    return loadingRawTx.hashCode ^
        loadingSignAndBroadcastTx.hashCode ^
        failedToCreateRawTx.hashCode ^
        failedToSignAndBroadcastTx.hashCode ^
        failedToFetchBalances.hashCode ^
        fetchingBalances.hashCode ^
        failedToRestoreWallet.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory UiState.fromMap(Map<String, dynamic> map) {
    return UiState(
      loadingRawTx: map['loadingRawTx'] ?? false,
      loadingSignAndBroadcastTx: map['loadingSignAndBroadcastTx'] ?? false,
      failedToCreateRawTx: map['failedToCreateRawTx'] ?? false,
      failedToSignAndBroadcastTx: map['failedToSignAndBroadcastTx'] ?? false,
      failedToFetchBalances: map['failedToFetchBalances'] ?? false,
      fetchingBalances: map['fetchingBalances'] ?? false,
      failedToRestoreWallet: map['failedToRestoreWallet'] ?? false,
    );
  }

  factory UiState.fromJson(String source) => UiState.fromMap(json.decode(source));
}
