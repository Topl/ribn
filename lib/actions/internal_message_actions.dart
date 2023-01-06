// Project imports:
import 'package:ribn/models/internal_message.dart';

class SendInternalMsgAction {
  final InternalMessage msg;
  SendInternalMsgAction(this.msg);
}

class ReceivedInternalMsgAction {
  final InternalMessage pendingRequest;
  ReceivedInternalMsgAction(this.pendingRequest);
}
