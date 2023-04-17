// Dart imports:
import 'dart:async';

// Package imports:
import 'package:brambldart/model.dart';

// Project imports:
import 'package:ribn/v1/models/internal_message.dart';
import 'package:ribn/v1/models/ribn_address.dart';
import 'package:ribn/v1/models/transfer_details.dart';

class InitiateTxAction {
  final TransferDetails transferDetails;
  final Completer<TransferDetails?> completer;
  const InitiateTxAction(this.transferDetails, this.completer);
}

class CreateRawTxAction {
  TransferDetails transferDetails;
  final Completer<TransferDetails?> completer;
  CreateRawTxAction(this.transferDetails, this.completer);
}

class SignTxAction {
  TransferDetails transferDetails;
  SignTxAction(this.transferDetails);
}

class SignAndBroadcastTxAction {
  TransferDetails transferDetails;
  final Completer<TransferDetails?> completer;
  SignAndBroadcastTxAction(this.transferDetails, this.completer);
}

class BroadcastTxAction {
  TransactionReceipt signedTx;
  RibnAddress? changeAddress;
  BroadcastTxAction(this.signedTx, {this.changeAddress});
}

class SignExternalTxAction {
  InternalMessage pendingRequest;
  SignExternalTxAction(this.pendingRequest);
}
