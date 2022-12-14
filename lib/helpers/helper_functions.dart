import 'package:brambldart/credentials.dart';
import 'package:brambldart/model.dart';
import 'package:flutter/cupertino.dart';
import '../containers/transaction_history_container.dart';

/// @dev Function fetches all transactions
/// @param context The current context which called the function within a widget
/// @parm toplAddress The address with which we are to fetch transactions for
/// @param networkId The network id which to fetch transactions from
/// @param transactionHistoryViewmodel The current instance of the TransactionHistoryViewmodel
/// @param currentPage The current page for which to fetch transactions for
/// @param filterSelectedItem The current filtered transaction type
/// @param filteredTransactions The list of existing filtered transactions
/// @returns List<TransactionReceipt>
Future<List<TransactionReceipt>> fetchTransactionHistory(
  BuildContext context,
  ToplAddress toplAddress,
  int networkId,
  TransactionHistoryViewmodel transactionHistoryViewmodel,
  int currentPage,
  String filterSelectedItem,
  List<TransactionReceipt> filteredTransactions,
) async {
  final List<TransactionReceipt> response =
      await transactionHistoryViewmodel.getTransactions(pageNum: currentPage);
  // Filters transactions by sent or received
  if (filterSelectedItem != 'Transaction types') {
    final List<TransactionReceipt> transactions = response;
    for (var transaction in transactions) {
      final String transactionReceiverAddress =
          transaction.to.first.toJson()[0].toString();
      final Sender transactionSenderAddress = transaction.from![0];
      final myRibnAddress = toplAddress.toBase58();
      final wasMinted = transaction.minting == true;
      if (filterSelectedItem == 'All') {
        filteredTransactions.add(transaction);
      }
      if (filterSelectedItem == 'Received' &&
          transactionReceiverAddress == myRibnAddress &&
          !wasMinted) {
        filteredTransactions.add(transaction);
      }
      if (filterSelectedItem == 'Sent' &&
          transactionSenderAddress.toString() == myRibnAddress.toString() &&
          !wasMinted &&
          transactionReceiverAddress != myRibnAddress) {
        filteredTransactions.add(transaction);
      }
    }
    return filteredTransactions;
  }
  return response;
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    final list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
