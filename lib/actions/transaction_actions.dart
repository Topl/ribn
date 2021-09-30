import 'package:mubrambl/src/transaction/transaction.dart';
import 'package:mubrambl/src/transaction/transactionReceipt.dart';

class InitiateTxAction {
  Map<String, dynamic> transferDetails;
  InitiateTxAction(this.transferDetails);
}

class CreateRawTxAction {
  Map<String, dynamic> transferDetails;
  CreateRawTxAction(this.transferDetails);
}

class SignTxAction {
  Map<String, dynamic> transferDetails;
  SignTxAction(this.transferDetails);
}

class BroadcastTxAction {
  TransactionReceipt signedTx;
  BroadcastTxAction(this.signedTx);
}
