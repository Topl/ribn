// Package imports:
import 'package:brambldart/brambldart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v1/providers/logger_provider.dart';

/// This filters out Change UTxOs
///
/// If the sender and the receiver address for a transaction is the same
/// then the assumption can be made that this output is a change UTxO with
/// the change going back to the sender
List<TransactionReceipt> filterOutChangeUTxO(List<TransactionReceipt> txs) {
  return txs.where((tx) {
    // Get the senders address
    final Sender? transactionSenderAddress = tx.from?[0];

    final ProviderContainer container = ProviderContainer();

    // If there is no sender, filter out and log issue
    if (transactionSenderAddress == null) {
      container.read(loggerProvider).log(
            logLevel: LogLevel.Severe,
            loggerClass: LoggerClass.Transaction,
            message: 'Transaction does not have a sender',
          );
      return false;
    }
    // Get the receivers address
    final String? transactionReceiverAddress = tx.to.first?.toJson()?[0].toString();

    // If there is no receiver, filter out and log issue
    if (transactionReceiverAddress == null) {
      container.read(loggerProvider).log(
            logLevel: LogLevel.Severe,
            loggerClass: LoggerClass.Transaction,
            message: 'Transaction does not have a receiver',
          );
      return false;
    }

    return transactionSenderAddress.toString() != transactionReceiverAddress;
  }).toList();
}
