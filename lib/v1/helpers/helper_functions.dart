// Flutter imports:

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:brambldart/credentials.dart';
import 'package:brambldart/model.dart';

// Project imports:
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
  final List<TransactionReceipt> response = await transactionHistoryViewmodel.getTransactions();
  // Filters transactions by sent or received
  if (filterSelectedItem != 'Transaction types') {
    final List<TransactionReceipt> transactions = response;
    for (var transaction in transactions) {
      final String transactionReceiverAddress = transaction.to.first.toJson()[0].toString();
      final Sender transactionSenderAddress = transaction.from![0];
      final myRibnAddress = toplAddress.toBase58();
      final wasMinted = transaction.minting == true;
      if (filterSelectedItem == 'All') {
        filteredTransactions.add(transaction);
      }
      if (filterSelectedItem == 'Received' && transactionReceiverAddress == myRibnAddress && !wasMinted) {
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
