import 'dart:async';

import 'package:brambldart/model.dart';

import 'package:ribn/models/internal_message.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/models/transfer_details.dart';

class InitiateTxAction {
  final TransferDetails transferDetails;
  final Completer<bool> completer;
  const InitiateTxAction(this.transferDetails, this.completer);
}

class CreateRawTxAction {
  TransferDetails transferDetails;
  final Completer<bool> completer;
  CreateRawTxAction(this.transferDetails, this.completer);
}

class SignTxAction {
  TransferDetails transferDetails;
  SignTxAction(this.transferDetails);
}

class SignAndBroadcastTxAction {
  TransferDetails transferDetails;
  SignAndBroadcastTxAction(this.transferDetails);
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
