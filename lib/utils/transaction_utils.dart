import 'package:brambldart/brambldart.dart';

/// This filters out Change UTxOs
///
/// If the sender and the receiver address for a transaction is the same
/// then the assumption can be made that this output is a change UTxO with
/// the change going back to the sender
List<TransactionReceipt> filterOutChangeUTxO(List<TransactionReceipt> txs) {
  return txs.where((tx) {
    // Get the senders address
    final Sender transactionSenderAddress = tx.from![0];

    // Get teh recievers address
    final String transactionReceiverAddress = tx.to.first.toJson()[0].toString();

    return transactionSenderAddress.toString() != transactionReceiverAddress;
  }).toList();
}
