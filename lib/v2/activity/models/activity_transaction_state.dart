import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_transaction_state.freezed.dart';

enum ActivityTransactionType {
  @JsonValue('received')
  received,
  @JsonValue('sent')
  sent,
  @JsonValue('fees')
  fees,
}

@freezed
class ActivityTransactionState with _$ActivityTransactionState {
  const factory ActivityTransactionState({
    required String transactionName,
    required DateTime transactionDateTime,
    required String transactionSymbol,
    required String transactionAmount,
    required String? transactionAmountInUSD,
    required ActivityTransactionType transactionType,
    required ActivityTransactionType transactionTypeEnum,
  }) = _ActivityTransactionState;

  static fromJson(e) {
    return ActivityTransactionState(
      transactionName: e['type'],
      transactionDateTime: e['date'],
      transactionSymbol: e['symbol'],
      transactionAmount: e['amount'],
      transactionAmountInUSD: e['amount'] * 10,
      transactionType: e['type'],
      transactionTypeEnum:
          ActivityTransactionType.values.firstWhere((element) => element.toString() == e['activityTransactionType']),
    );
  }
}
