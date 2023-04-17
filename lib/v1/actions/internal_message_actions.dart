// Project imports:
import 'package:ribn/v1/models/internal_message.dart';

class SendInternalMsgAction {
  final InternalMessage msg;
  SendInternalMsgAction(this.msg);
}

class ReceivedInternalMsgAction {
  final InternalMessage pendingRequest;
  ReceivedInternalMsgAction(this.pendingRequest);
}
