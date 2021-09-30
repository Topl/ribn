import 'package:mubrambl/brambldart.dart';
import 'package:ribn/models/ribn_address.dart';

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
  RibnAddress? changeAddress;
  BroadcastTxAction(this.signedTx, {this.changeAddress});
}
