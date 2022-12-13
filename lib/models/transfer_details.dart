import 'dart:typed_data';

import 'package:brambldart/brambldart.dart';
import 'package:flutter/foundation.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/models/ribn_address.dart';


/// A helper class to hold all the details for a transfer being initiated inside Ribn.
class TransferDetails {
  final TransferType transferType;
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
