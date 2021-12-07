/// A helper class that holds the UI State of Ribn.
class UiState {
  /// A loading indicator used during transfer flows.
  final bool loadingRawTx;
  UiState({
    required this.loadingRawTx,
  });

  factory UiState.initial() {
    return UiState(
      loadingRawTx: false,
    );
  }

  UiState copyWith({
    bool? loadingRawTx,
  }) {
    return UiState(
      loadingRawTx: loadingRawTx ?? this.loadingRawTx,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadingRawTx': loadingRawTx,
    };
  }

  @override
  String toString() => 'UiState(loadingRawTx: $loadingRawTx)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UiState && other.loadingRawTx == loadingRawTx;
  }

  @override
  int get hashCode => loadingRawTx.hashCode;
}
