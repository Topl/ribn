import 'dart:typed_data';

import 'package:brambldart/brambldart.dart';
import 'package:flutter/foundation.dart';

import 'package:ribn/models/ribn_address.dart';

/// A helper class to hold all the details for a transfer being initiated inside Ribn.
class TransferDetails {
  final String transferType;
  final String amount;
  final String recipient;
  final List<RibnAddress> senders;
  final String data;
  final RibnAddress? change;
  final RibnAddress? consolidation;
  final AssetCode? assetCode;
  final int? networkId;
  final TransactionReceipt? transactionReceipt;
  final Uint8List? messageToSign;
  final String? transactionId;
  TransferDetails({
    required this.transferType,
    required this.amount,
    required this.recipient,
    this.senders = const [],
    this.change,
    this.consolidation,
    this.assetCode,
    required this.data,
    this.networkId,
    this.transactionReceipt,
    this.messageToSign,
    this.transactionId,
  });

  TransferDetails copyWith({
    String? transferType,
    String? amount,
    String? recipient,
    List<RibnAddress>? senders,
    RibnAddress? change,
    RibnAddress? consolidation,
    AssetCode? assetCode,
    String? data,
    int? networkId,
    TransactionReceipt? transactionReceipt,
    Uint8List? messageToSign,
    String? transactionId,
  }) {
    return TransferDetails(
      transferType: transferType ?? this.transferType,
      amount: amount ?? this.amount,
      recipient: recipient ?? this.recipient,
      senders: senders ?? this.senders,
      change: change ?? this.change,
      consolidation: consolidation ?? this.consolidation,
      assetCode: assetCode ?? this.assetCode,
      data: data ?? this.data,
      networkId: networkId ?? this.networkId,
      transactionReceipt: transactionReceipt ?? this.transactionReceipt,
      messageToSign: messageToSign ?? this.messageToSign,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  @override
  String toString() {
    return 'TransferDetails(transferType: $transferType, amount: $amount, recipient: $recipient, senders: $senders, change: $change, consolidation: $consolidation, assetCode: $assetCode, data: $data, networkId: $networkId, transactionReceipt: $transactionReceipt, messageToSign: $messageToSign, transactionId: $transactionId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransferDetails &&
        other.transferType == transferType &&
        other.amount == amount &&
        other.recipient == recipient &&
        listEquals(other.senders, senders) &&
        other.change == change &&
        other.consolidation == consolidation &&
        other.assetCode == assetCode &&
        other.data == data &&
        other.networkId == networkId &&
        other.transactionReceipt == transactionReceipt &&
        other.messageToSign == messageToSign &&
        other.transactionId == transactionId;
  }

  @override
  int get hashCode {
    return transferType.hashCode ^
        amount.hashCode ^
        recipient.hashCode ^
        senders.hashCode ^
        change.hashCode ^
        consolidation.hashCode ^
        assetCode.hashCode ^
        data.hashCode ^
        networkId.hashCode ^
        transactionReceipt.hashCode ^
        messageToSign.hashCode ^
        transactionId.hashCode;
  }
}
