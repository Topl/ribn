// Dart imports:

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:brambldart/brambldart.dart';

// Project imports:
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/models/ribn_address.dart';

/// A helper class to hold all the details for a transfer being initiated inside Ribn.
class TransferDetails {
  /// The type of transfer
  final TransferType transferType;

  /// The amount being transferred in nanoPoly's
  final String amount;

  /// Address of the recipient
  final String recipient;

  /// The sender/s address/s of this transaction.
  final List<RibnAddress> senders;

  /// Extra data pertaining to transfer
  final String data;

  /// The address to send leftover [Poly] tokens
  final RibnAddress? change;

  /// The address to send leftover [Asset] and [Arbit] tokens
  final RibnAddress? consolidation;

  /// AssetCode serves as a unique identifier for user issued assets
  final AssetCode? assetCode;

  /// The networkId for returning correct transaction data per each Topl network
  final int? networkId;

  /// Receipt for the transaction
  final TransactionReceipt? transactionReceipt;

  /// The message that will have to be signed by the sender of this transaction
  final Uint8List? messageToSign;

  /// The id of this transaction
  final String? transactionId;

  /// User defined asset details.
  final AssetDetails? assetDetails;

  TransferDetails({
    required this.transferType,
    required this.amount,
    required this.recipient,
    this.senders = const [],
    required this.data,
    this.change,
    this.consolidation,
    this.assetCode,
    this.networkId,
    this.transactionReceipt,
    this.messageToSign,
    this.transactionId,
    this.assetDetails,
  });

  TransferDetails copyWith({
    TransferType? transferType,
    String? amount,
    String? recipient,
    List<RibnAddress>? senders,
    String? data,
    RibnAddress? change,
    RibnAddress? consolidation,
    AssetCode? assetCode,
    int? networkId,
    TransactionReceipt? transactionReceipt,
    Uint8List? messageToSign,
    String? transactionId,
    AssetDetails? assetDetails,
  }) {
    return TransferDetails(
      transferType: transferType ?? this.transferType,
      amount: amount ?? this.amount,
      recipient: recipient ?? this.recipient,
      senders: senders ?? this.senders,
      data: data ?? this.data,
      change: change ?? this.change,
      consolidation: consolidation ?? this.consolidation,
      assetCode: assetCode ?? this.assetCode,
      networkId: networkId ?? this.networkId,
      transactionReceipt: transactionReceipt ?? this.transactionReceipt,
      messageToSign: messageToSign ?? this.messageToSign,
      transactionId: transactionId ?? this.transactionId,
      assetDetails: assetDetails ?? this.assetDetails,
    );
  }

  @override
  String toString() {
    return 'TransferDetails(transferType: $transferType, amount: $amount, recipient: $recipient, senders: $senders, data: $data, change: $change, consolidation: $consolidation, assetCode: $assetCode, networkId: $networkId, transactionReceipt: $transactionReceipt, messageToSign: $messageToSign, transactionId: $transactionId, assetDetails: $assetDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransferDetails &&
        other.transferType == transferType &&
        other.amount == amount &&
        other.recipient == recipient &&
        listEquals(other.senders, senders) &&
        other.data == data &&
        other.change == change &&
        other.consolidation == consolidation &&
        other.assetCode == assetCode &&
        other.networkId == networkId &&
        other.transactionReceipt == transactionReceipt &&
        other.messageToSign == messageToSign &&
        other.transactionId == transactionId &&
        other.assetDetails == assetDetails;
  }

  @override
  int get hashCode {
    return transferType.hashCode ^
        amount.hashCode ^
        recipient.hashCode ^
        senders.hashCode ^
        data.hashCode ^
        change.hashCode ^
        consolidation.hashCode ^
        assetCode.hashCode ^
        networkId.hashCode ^
        transactionReceipt.hashCode ^
        messageToSign.hashCode ^
        transactionId.hashCode ^
        assetDetails.hashCode;
  }
}
